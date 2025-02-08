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
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/ViewTopSpendingUsersServlet")
public class ViewTopSpendingUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewTopSpendingUsersServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Users> usersList = null;

        // Check if a filter is applied
        String filterType = request.getParameter("filter");
        String minSpent = request.getParameter("minSpent");

        if ("top10".equals(filterType)) {
            usersList = UserDAO.getTopSpendingUsers();
        } else if (minSpent != null && !minSpent.isEmpty()) {
            try {
                BigDecimal minAmount = new BigDecimal(minSpent);
                usersList = UserDAO.getUsersByMinimumSpending(minAmount, null);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid amount entered.");
            }
        } else {
            usersList = UserDAO.getAllUsersWithSpending();
        }

        request.setAttribute("usersList", usersList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CA2/viewTopSpendingUsers.jsp");
        dispatcher.forward(request, response);
    }
}
