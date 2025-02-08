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

@WebServlet("/GetBestAndLeastRatedServices")
public class GetBestAndLeastRatedServicesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GetBestAndLeastRatedServicesServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Client client = ClientBuilder.newClient();

        // Fetch best-rated services
        String bestRatedUrl = "http://localhost:8081/ca2-ws/getHighestRatedServices";
        WebTarget bestRatedTarget = client.target(bestRatedUrl);
        Invocation.Builder bestRatedBuilder = bestRatedTarget.request(MediaType.APPLICATION_JSON);
        Response bestRatedResp = bestRatedBuilder.get();

        if (bestRatedResp.getStatus() == Response.Status.OK.getStatusCode()) {
            List<Services> bestRatedServices = bestRatedResp.readEntity(new GenericType<List<Services>>() {});
            request.setAttribute("bestRatedServices", bestRatedServices);
            System.out.print("services found"+bestRatedServices );
        } else {
            request.setAttribute("bestRatedServices", null);
        }

        // Fetch least-rated services
        String leastRatedUrl = "http://localhost:8081/ca2-ws/getLowestRatedServices";
        WebTarget leastRatedTarget = client.target(leastRatedUrl);
        Invocation.Builder leastRatedBuilder = leastRatedTarget.request(MediaType.APPLICATION_JSON);
        Response leastRatedResp = leastRatedBuilder.get();

        if (leastRatedResp.getStatus() == Response.Status.OK.getStatusCode()) {
            List<Services> leastRatedServices = leastRatedResp.readEntity(new GenericType<List<Services>>() {});
            request.setAttribute("leastRatedServices", leastRatedServices);
        } else {
            request.setAttribute("leastRatedServices", null);
        }

        // Forward to JSP page for display
        RequestDispatcher rd = request.getRequestDispatcher("CA2/bestAndLeastRatedServices.jsp");
        rd.forward(request, response);
    }
}
