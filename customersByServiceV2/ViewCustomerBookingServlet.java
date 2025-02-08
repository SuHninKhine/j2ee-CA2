package servlets;

import dbaccess.Users;
import dbaccess.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewCustomerServiceBookingServlet")
public class ViewCustomerServiceBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int serviceId = Integer.parseInt(request.getParameter("serviceId"));

        // Fetch the customers who booked the service
        List<Users> customers = UserDAO.getCustomersByService(serviceId);

        // Set attribute and forward to a new JSP for displaying customers
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("CA2/ViewCustomerServiceBooking.jsp").forward(request, response);
    }
}
