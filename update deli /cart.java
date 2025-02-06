package dbaccess;

import java.time.LocalDateTime;

public class Cart {
	private int cartItemId;
    private int userId;
    private int bookingId;
    private Float totalAmount;
    private LocalDateTime createdAt;
    private String status;
    
    
    
    public Cart() {}

    public Cart(int userId, int bookingId, Float totalAmount) {
        this.userId = userId;
        this.bookingId = bookingId;
        this.totalAmount = totalAmount;
        this.createdAt = LocalDateTime.now();
    }
    
	public int getCartItemId() {
		return cartItemId;
	}
	public void setCartItemId(int cartItemId) {
		this.cartItemId = cartItemId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public Float getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(Float totalAmount) {
		this.totalAmount = totalAmount;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public String getStatus() { 
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


}
