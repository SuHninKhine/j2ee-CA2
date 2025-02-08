package servlets;

import dbaccess.ServiceDAO;
import dbaccess.ServiceCategories;
import dbaccess.Services;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/FilterServiceServlet")
public class FilterServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all categories for the filter dropdown
        List<ServiceCategories> categories = ServiceDAO.getAllCategories();
        
        // Get filter parameters (categoryId and serviceId)
        String categoryParam = request.getParameter("category");
        String serviceParam = request.getParameter("service");
        
        Integer categoryId = (categoryParam != null && !categoryParam.isEmpty()) ? Integer.parseInt(categoryParam) : null;
        Integer serviceId = (serviceParam != null && !serviceParam.isEmpty()) ? Integer.parseInt(serviceParam) : null;

        // Get the filtered services
        List<Services> services = ServiceDAO.getFilteredServices(categoryId, serviceId);

        // Set attributes to be used in JSP
        request.setAttribute("categories", categories);
        request.setAttribute("services", services);

        // Forward to the JSP page
        request.getRequestDispatcher("CA2/filterServices.jsp").forward(request, response);
    }
}
