// - Author(s): Your Name
// - Date: 2/7/2025
// - Copyright Notice: © 2025 Your Name. All rights reserved
// - @(#)
// - Description: Fetches services by category and forwards them to JSP

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
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.core.Response;
import dbaccess.Services;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/GetServicesByCategory")
public class GetServicesByCategory extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GetServicesByCategory() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("categoryId");
        if (categoryId == null || categoryId.isEmpty()) {
            request.setAttribute("error", "Category ID is required.");
            RequestDispatcher rd = request.getRequestDispatcher("/services.jsp");
            rd.forward(request, response);
            return;
        }

        Client client = ClientBuilder.newClient();
        String restUrl = "http://localhost:8081/ca2-ws/getServicesByCategory/" + categoryId;
        WebTarget target = client.target(restUrl);
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response resp = invocationBuilder.get();

        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
            List<Services> servicesList = resp.readEntity(new GenericType<List<Services>>() {});
            request.setAttribute("servicesList", servicesList);
        } else {
            request.setAttribute("error", "No services found for this category.");
        }

        RequestDispatcher rd = request.getRequestDispatcher("CA2/services.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
