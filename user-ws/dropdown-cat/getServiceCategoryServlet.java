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
import dbaccess.ServiceCategories;

import java.io.IOException;
import java.util.List;

@WebServlet("/GetServiceCategories")
public class GetServiceCategoriesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GetServiceCategoriesServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Client client = ClientBuilder.newClient();
        String restUrl = "http://localhost:8081/ca2-ws/getAllCategories"; // REST API URL
        WebTarget target = client.target(restUrl);
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response resp = invocationBuilder.get();

        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
            List<ServiceCategories> categories = resp.readEntity(new GenericType<List<ServiceCategories>>() {});
            request.setAttribute("categories", categories);
        } else {
            request.setAttribute("categories", null);
        }

//        // Corrected path to JSP
        RequestDispatcher rd = request.getRequestDispatcher("CA2/serviceFunctionalities.jsp");
        rd.forward(request, response);
        
//        response.sendRedirect(request.getContextPath() + "/FilterServicesServlet");
    }
}
