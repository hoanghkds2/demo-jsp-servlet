<%-- 
    Document   : demo crud 
    Created on : Nov 2, 2024, 11:15:24 AM 
    Author     : Administrator 
--%> 

<%@ page contentType="text/html" pageEncoding="UTF-8" import="DAO.*, java.util.*, model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            .edit-form {
                display: none; /* Ẩn form sửa mặc định */
            }
            .add-form {
                display: none; /* Ẩn form thêm người dùng mặc định */
            }
        </style>
        <script>
            function toggleEditForm(formId) {
                const form = document.getElementById(formId);
                if (form.style.display === "none") {
                    form.style.display = "block"; // Hiện form sửa
                } else {
                    form.style.display = "none"; // Ẩn form sửa
                }
            }

            function toggleDeleteForm(formId) {
                const form = document.getElementById(formId);
                form.style.display = (form.style.display === "none") ? "block" : "none"; // Chuyển đổi hiển thị form xóa
            }
            
            function toggleAddForm() {
            const addForm = document.getElementById('addUserForm');
            addForm.style.display = (addForm.style.display === "none") ? "block" : "none"; // Chuyển đổi hiển thị form thêm người dùng
        }
        </script>

    </head>
    <body>
        <%
        List<User> users = new UserDAO().getAllUsers();
        %>

        <h1>User List</h1>
        <table border="1">
            <tr>
                <th>User ID</th>
                <th>Username</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Phone Number</th>
                <th>Tác vụ</th>
            </tr>
            <% 
            for(User user : users) { 
            %>
            <tr>
                <td><%= user.getUserID() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getFirstName() %></td>
                <td><%= user.getLastName() %></td>
                <td><%= user.getPhoneNumber() %></td>
                <td style="display: flex; flex-direction: row; text-align: center">
                    <!-- Nút sửa -->
                    <button type="button" onclick="toggleEditForm('editForm<%= user.getUserID() %>')">Sửa</button>

                    <!-- Form sửa -->
                    <form id="editForm<%= user.getUserID() %>" class="edit-form" action="updateUser" method="POST">
                        <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                        <input type="text" name="username" value="<%= user.getUsername() %>">
                        <input type="text" name="firstName" value="<%= user.getFirstName() %>">
                        <input type="text" name="lastName" value="<%= user.getLastName() %>">
                        <input type="text" name="phoneNumber" value="<%= user.getPhoneNumber() %>">
                        <div class="justify-content-center">
                            <input type="submit" value="Cập nhật"/>
                        </div>
                    </form>
                    <form action="deleteUser" method="POST" style="margin-left: 10px;">
                        <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                        <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">
                            Xoá
                        </button>
                    </form>
                    </form>
                </td>
            </tr>
            <% 
            } 
            %>
        </table>

        <div style="margin-top: 20px;">
            <button type="button" onclick="toggleAddForm()">Thêm Người Dùng</button>
        </div>


        <!-- Form thêm người dùng -->
        <form id="addUserForm" class="add-form" action="addUser" method="POST">
            <h3>Thêm Người Dùng Mới</h3>
            <input type="text" name="username" placeholder="Username" required>
            <input type="text" name="firstName" placeholder="Họ" required>
            <input type="text" name="lastName" placeholder="Tên" required>
            <input type="text" name="phoneNumber" placeholder="Số Điện Thoại" required>
            <div class="justify-content-center">
                <input type="submit" value="Thêm"/>
            </div>
        </form>


    </body>
</html>
