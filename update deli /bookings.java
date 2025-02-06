package dbaccess;

import java.time.LocalDateTime;

public class Bookings {
    private int bookingId; // Auto-increment in DB
    private int userId;
    private int serviceId;
    private LocalDateTime appointmentDate;
    private String specialRequests;
    private String status;
    private String address;
    private LocalDateTime bookingDate; // Store date as String for easier serialization
    private String serviceName;
    private String customerName;
    private String email;
    private float revenueLost;
    private Cart cart;

    
    // Default constructor
    public Bookings() {}

    // Constructor without bookingId since it's auto-incremented
    public Bookings(int userId, int serviceId, LocalDateTime appointmentDate, String specialRequests, String address) {
        this.userId = userId;
        this.serviceId = serviceId;
        this.appointmentDate = appointmentDate;
        this.specialRequests = specialRequests;
        this.address = address;
        this.status = "Pending"; // Default status
        this.bookingDate = LocalDateTime.now(); // Store as ISO 8601 string
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public LocalDateTime getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(LocalDateTime appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getSpecialRequests() {
        return specialRequests;
    }

    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public LocalDateTime getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(LocalDateTime bookingDate) {
        this.bookingDate = bookingDate;
    }

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public float getRevenueLost() {
		return revenueLost;
	}

	public void setRevenueLost(float revenueLost) {
		this.revenueLost = revenueLost;
	}

	public Cart getCart() {
	    return cart;
	}

	public void setCart(Cart cart) {
	    this.cart = cart;
	}




    
}
