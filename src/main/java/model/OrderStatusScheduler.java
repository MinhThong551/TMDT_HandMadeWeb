package model;

import dao.client.JDBCUtil;
import dao.client.OrderDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class OrderStatusScheduler {
    Connection connection = JDBCUtil.getConnection();
    public void startScheduledTask() {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        Runnable task = () -> {
                String selectSQL = "SELECT id FROM Orders WHERE orderStatus = 'Đang giao hàng' AND TIMESTAMPDIFF(MINUTE, booking_date, NOW()) >= 5";
                try (PreparedStatement selectStatement = connection.prepareStatement(selectSQL);
                     ResultSet resultSet = selectStatement.executeQuery()) {
                    while (resultSet.next()) {
                        int orderId = resultSet.getInt("id");
                        OrderDAO.updateOrderStatus(orderId, "Giao hàng thành công");
                        OrderDAO.updateDeliveryDate(orderId);
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
        };

        scheduler.scheduleAtFixedRate(task, 0, 5, TimeUnit.SECONDS); // Chạy task mỗi 5 giây
    }
}
