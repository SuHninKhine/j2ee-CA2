package servlets;

import dbaccess.ServiceDAO;
import dbaccess.Services;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewRatedServicesServlet")
public class ViewRatedServicesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewRatedServicesServlet() {
        super();
    }

//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String type = request.getParameter("type"); // "best" or "lowest"
//        System.out.print("type is"+type);
//        System.out.print("type2 is"+ (request.getParameter("type")));
//
//        boolean bestRated = "best".equals(type);
//        List<Services> services = ServiceDAO.getTopRatedServices(bestRated);
//
//        request.setAttribute("services", services);
//        request.setAttribute("type", type);
//
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/CA2/viewRatedServices.jsp");
//        dispatcher.forward(request, response);
//    }
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type"); // "best" or "lowest"
        
        System.out.println("All Request Parameters:");
        request.getParameterMap().forEach((key, value) -> System.out.println(key + " = " + String.join(",", value)));

        if (type == null) {
            System.out.println("Warning: 'type' parameter is null!");
        } else {
            System.out.println("Type is: " + type);
        }

        boolean bestRated = "best".equals(type);
        List<Services> services = ServiceDAO.getTopRatedServices(bestRated);

        request.setAttribute("services", services);
        request.setAttribute("type", type);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CA2/viewRatedServices.jsp");
        dispatcher.forward(request, response);
    }

}
