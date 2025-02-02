package servlets;

import dbaccess.BookingDAO;
import dbaccess.Bookings;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/ViewBookingsServlet")
public class ViewBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewBookingsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filterType = request.getParameter("filterType"); // "date", "month", "year", "period"
        List<Bookings> bookings = null;

        if ("date".equals(filterType)) {
            String dateStr = request.getParameter("date");
            LocalDate date = LocalDate.parse(dateStr);
            bookings = BookingDAO.getBookingsByDate(date);
        } else if ("month".equals(filterType)) {
            int year = Integer.parseInt(request.getParameter("year"));
            int month = Integer.parseInt(request.getParameter("month"));
            bookings = BookingDAO.getBookingsByMonth(year, month);
        } else if ("year".equals(filterType)) {  // Handle year filter
            int year = Integer.parseInt(request.getParameter("yearOnly"));
            bookings = BookingDAO.getBookingsByYear(year);
        } else if ("period".equals(filterType)) {
            String period = request.getParameter("period");
            bookings = BookingDAO.getBookingsByPeriod(period);
        }

        request.setAttribute("bookings", bookings);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CA2/viewBookings.jsp");
        dispatcher.forward(request, response);
    }
}
