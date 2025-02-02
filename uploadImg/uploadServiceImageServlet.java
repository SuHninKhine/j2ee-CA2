package servlets;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import dbaccess.ServiceDAO;

@WebServlet("/uploadServiceImage")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UploadServiceImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "C:/Users/Ssuhn/Downloads/ca2/ca2/src/main/webapp/CA2/service_images";

    public UploadServiceImageServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int serviceId = -1;
        try {
            serviceId = Integer.parseInt(request.getParameter("serviceId"));
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid service ID.");
            request.getRequestDispatcher("/CA2/uploadResult.jsp").forward(request, response);
            return;
        }

        Part filePart = request.getPart("serviceImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // Save in your actual directory
            String uploadPath = UPLOAD_DIR;
            System.out.println("Upload Path: " + uploadPath);

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
                System.out.println("Created upload directory.");
            }

            String filePath = uploadPath + File.separator + fileName;
            System.out.println("Saving file to: " + filePath);

            filePart.write(filePath);
            System.out.println("File saved successfully!");

            // Store relative path in DB
            String imagePath = "CA2/service_images/" + fileName;
            ServiceDAO serviceDAO = new ServiceDAO();
            boolean isUpdated = false;
            try {
                System.out.println("Updating database with serviceId: " + serviceId + " and imagePath: " + imagePath);
                isUpdated = serviceDAO.updateServiceImage(serviceId, imagePath);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (isUpdated) {
                request.setAttribute("message", "Service image uploaded successfully!");
            } else {
                request.setAttribute("message", "Failed to update service image in the database.");
            }

            request.setAttribute("imagePath", imagePath);
        } else {
            request.setAttribute("message", "No file uploaded. Please select an image.");
        }

        request.getRequestDispatcher("/CA2/uploadResult.jsp").forward(request, response);
    }
}





//package servlets;
//
//import java.io.File;
//import java.io.IOException;
//import java.nio.file.Paths;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.Part;
//
//import dbaccess.ServiceDAO;
//
//@WebServlet("/uploadServiceImage")
//@MultipartConfig(
//    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
//    maxFileSize = 1024 * 1024 * 10,      // 10MB
//    maxRequestSize = 1024 * 1024 * 50    // 50MB
//)
//public class UploadServiceImageServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//    private static final String UPLOAD_DIR = "CA2/service_images"; // Adjusted path inside webapp
//
//    public UploadServiceImageServlet() {
//        super();
//    }
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int serviceId = -1; // Default invalid value
//        try {
//            serviceId = Integer.parseInt(request.getParameter("serviceId"));
//        } catch (NumberFormatException e) {
//            request.setAttribute("message", "Invalid service ID.");
//            request.getRequestDispatcher("/CA2/uploadResult.jsp").forward(request, response);
//            return;
//        }
//
//        Part filePart = request.getPart("serviceImage");
//
//        if (filePart != null && filePart.getSize() > 0) {
//            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//            
//            // Get the absolute path to store image
//            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
//            System.out.println("Upload Path: " + uploadPath);
//
//            File uploadDir = new File(uploadPath);
//            if (!uploadDir.exists()) {
//                uploadDir.mkdirs(); // Create directory if it doesn't exist
//                System.out.println("Created upload directory.");
//            }
//
//            String filePath = uploadPath + File.separator + fileName;
//            System.out.println("Saving file to: " + filePath);
//
//            filePart.write(filePath);
//            System.out.println("File saved successfully!");
//
//            // Store relative path in DB
//            String imagePath = UPLOAD_DIR + "/" + fileName;
//            ServiceDAO serviceDAO = new ServiceDAO();
//            boolean isUpdated = false;
//            try {
//                System.out.println("Updating database with serviceId: " + serviceId + " and imagePath: " + imagePath);
//                isUpdated = serviceDAO.updateServiceImage(serviceId, imagePath);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//
//            if (isUpdated) {
//                request.setAttribute("message", "Service image uploaded successfully!");
//            } else {
//                request.setAttribute("message", "Failed to update service image in the database.");
//            }
//        } else {
//            request.setAttribute("message", "No file uploaded. Please select an image.");
//        }
//
//        request.getRequestDispatcher("/CA2/uploadResult.jsp").forward(request, response);
//    }
//}
//



//package servlets;
//
//import java.io.File;
//import java.io.IOException;
//import java.nio.file.Paths;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.Part;
//
//import dbaccess.ServiceDAO;
//
//@WebServlet("/uploadServiceImage")
//@MultipartConfig(
//    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
//    maxFileSize = 1024 * 1024 * 10,      // 10MB
//    maxRequestSize = 1024 * 1024 * 50    // 50MB
//)
//public class UploadServiceImageServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//    private static final String UPLOAD_DIR = "CA2/service_images"; // Adjusted path inside webapp
//
//    public UploadServiceImageServlet() {
//        super();
//    }
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int serviceId = Integer.parseInt(request.getParameter("serviceId"));
//        Part filePart = request.getPart("serviceImage");
//
//        if (filePart != null && filePart.getSize() > 0) {
//            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//            
//            // Get the absolute path to store image
//            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
//            File uploadDir = new File(uploadPath);
//            
//            if (!uploadDir.exists()) {
//                uploadDir.mkdirs(); // Create directory if it doesn't exist
//            }
//
//            String filePath = uploadPath + File.separator + fileName;
//            filePart.write(filePath);
//
//            // Store relative path in DB
//            String imagePath = UPLOAD_DIR + "/" + fileName;
//            ServiceDAO serviceDAO = new ServiceDAO();
//            boolean isUpdated = false;
//			try {
//				isUpdated = serviceDAO.updateServiceImage(serviceId, imagePath);
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//
//            if (isUpdated) {
//                request.setAttribute("message", "Service image uploaded successfully!");
//            } else {
//                request.setAttribute("message", "Failed to update service image in the database.");
//            }
//        } else {
//            request.setAttribute("message", "No file uploaded. Please select an image.");
//        }
//
//        request.getRequestDispatcher("/CA2/uploadResult.jsp").forward(request, response);
//    }
//}
