package servlets;

import dbaccess.UserDAO;
import dbaccess.Users;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewCustomersServlet")
public class ViewCustomersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewCustomersServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serviceIdStr = request.getParameter("service_id");

        if (serviceIdStr != null && !serviceIdStr.isEmpty()) {
            int service_id = Integer.parseInt(serviceIdStr);
            List<Users> customers = UserDAO.getCustomersByService(service_id);

            request.setAttribute("customers", customers);
            request.setAttribute("service_id", service_id);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CA2/viewCustomers.jsp");
        dispatcher.forward(request, response);
    }
}
