package servlets;

import dbaccess.UserDAO;
import dbaccess.ServiceCategories;
import dbaccess.Services;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/CategoryServiceServlet")
public class CategoryServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CategoryServiceServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ServiceCategories> categories = UserDAO.getAllCategories();
        request.setAttribute("categories", categories);
        System.out.printf("categories", categories);
        
        String categoryIdStr = request.getParameter("category_id");
        if (categoryIdStr != null) {
            int categoryId = Integer.parseInt(categoryIdStr);
            List<Services> services = UserDAO.getServicesByCategory(categoryId);
            request.setAttribute("services", services);
            System.out.printf("services", services);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CA2/viewCustomers.jsp");
        dispatcher.forward(request, response);
    }
}
