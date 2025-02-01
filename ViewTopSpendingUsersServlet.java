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

@WebServlet("/ViewTopSpendingUsersServlet")
public class ViewTopSpendingUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewTopSpendingUsersServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetching top spending users
        List<Users> topUsers = null;
		try {
			topUsers = UserDAO.getTopSpendingUsers();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        request.setAttribute("topUsers", topUsers);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CA2/viewTopSpendingUsers.jsp");
        dispatcher.forward(request, response);
    }
}
