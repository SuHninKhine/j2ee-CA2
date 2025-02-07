package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
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

@WebServlet("/GetServicesByCategory")
public class FilterServicesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public FilterServicesServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("categoryId");
        Client client = ClientBuilder.newClient();
        String restUrl;

        // If no category is selected, fetch all services
        if (categoryId == null || categoryId.isEmpty()) {
            restUrl = "http://localhost:8081/ca2-ws/getAllServices";
            request.setAttribute("selectedCategoryId", "");  // No selection
        } else {
            restUrl = "http://localhost:8081/ca2-ws/getServicesByCategory/" + categoryId;
            request.setAttribute("selectedCategoryId", categoryId);
        }

        WebTarget target = client.target(restUrl);
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response resp = invocationBuilder.get();

        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
            List<Services> servicesList = resp.readEntity(new GenericType<List<Services>>() {});
            request.setAttribute("servicesList", servicesList);
        } else {
            request.setAttribute("servicesList", null);
        }

        RequestDispatcher rd = request.getRequestDispatcher("CA2/serviceFunctionalities.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
