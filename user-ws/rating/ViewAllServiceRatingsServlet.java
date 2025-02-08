package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import dbaccess.Services;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewAllServiceRatingsServlet")
public class ViewAllServiceRatingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewAllServiceRatingsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filterType = request.getParameter("filterType");
        String minRating = request.getParameter("minRating");

        // Set default values if no parameters are passed
        if (filterType == null) filterType = "all";
        if (minRating == null) minRating = "1"; // Default to 1-star and above

        Client client = ClientBuilder.newClient();
     // Fetch all services (with avgRating dynamically calculated)
        String apiUrl = "http://localhost:8081/ca2-ws/getAllServicesWithRatings";


        // Determine API URL based on filter type
        if ("highest".equals(filterType)) {
            apiUrl = "http://localhost:8081/ca2-ws/getHighestRatedServices";
        } else if ("lowest".equals(filterType)) {
            apiUrl = "http://localhost:8081/ca2-ws/getLowestRatedServices";
        } else if ("rating".equals(filterType)) {
            apiUrl = "http://localhost:8081/ca2-ws/getServicesByRating/" + minRating;
        }

        WebTarget target = client.target(apiUrl);
        Invocation.Builder builder = target.request(MediaType.APPLICATION_JSON);
        Response serviceResp = builder.get();

        if (serviceResp.getStatus() == Response.Status.OK.getStatusCode()) {
            List<Services> servicesList = serviceResp.readEntity(new GenericType<List<Services>>() {});
            request.setAttribute("servicesList", servicesList);
        } else {
            request.setAttribute("servicesList", null);
        }

        // Pass the selected filter values to JSP
        request.setAttribute("selectedFilter", filterType);
        request.setAttribute("selectedRating", minRating);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("CA2/viewAllServiceRatings.jsp");
        rd.forward(request, response);
    }
}
