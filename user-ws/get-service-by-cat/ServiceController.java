package com.service.ca2_ws.controller;

import org.springframework.web.bind.annotation.*;
import com.service.ca2_ws.dbaccess.ServiceDAO;
import com.service.ca2_ws.dbaccess.Services;

import java.util.List;

@RestController
public class ServiceController {

    @RequestMapping(method = RequestMethod.GET, path = "/getServicesByCategory/{categoryId}")
    public List<Services> getServicesByCategory(@PathVariable("categoryId") int categoryId) {
        List<Services> services = null;
        try {
            ServiceDAO serviceDAO = new ServiceDAO();
            services = serviceDAO.getServicesByCategory(categoryId);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return services;
    }
}
