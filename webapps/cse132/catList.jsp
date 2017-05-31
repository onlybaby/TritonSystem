<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>

            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    String dbURL = "jdbc:postgresql://localhost:9999/cse132?user=postgres&password=admin";
                    Connection conn = DriverManager.getConnection(dbURL);

            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);



                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO CATEGORY_LIST VALUES (?, ?, ?, ?)");

                            pstmt.setString(1, request.getParameter("CATE_NAME"));
                            pstmt.setString(2, request.getParameter("COURSE"));
                            pstmt.setString(3, request.getParameter("DEGREE_NAME"));
                            pstmt.setString(4, request.getParameter("DEGREE_TYPE"));
                            int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);

                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE CATEGORY_LIST SET CATE_NAME = ?, COURSE = ?, DEGREE_NAME = ?, DEGREE_TYPE = ?");

                            pstmt.setString(1, request.getParameter("CATE_NAME"));
                            pstmt.setString(2, request.getParameter("COURSE"));
                            pstmt.setString(3, request.getParameter("DEGREE_NAME"));
                            pstmt.setString(4, request.getParameter("DEGREE_TYPE"));
                        //     pstmt.setInt(
                        //         3, Integer.parseInt(request.getParameter("PID")));
                        //     pstmt.setString(4, request.getParameter("FACULTY"));
                         int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);

                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM CATEGORY_LIST WHERE CATE_NAME = ? AND COURSE = ? AND DEGREE_NAME = ? AND DEGREE_TYPE = ?");

                            pstmt.setString(1, request.getParameter("CATE_NAME"));
                            pstmt.setString(2, request.getParameter("COURSE"));
                            pstmt.setString(3, request.getParameter("DEGREE_NAME"));
                            pstmt.setString(4, request.getParameter("DEGREE_TYPE"));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();
                    Statement statement2 = conn.createStatement();
                    Statement statement1 = conn.createStatement();
                    Statement statement3 = conn.createStatement();
                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM CATEGORY_LIST");
            %>


            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>CATE_NAME</th>
                        <th>COURSE</th>
                        <th>DEGREE NAME</th>
                        <th>DEGREE TYPE</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="catList.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><select name="CATE_NAME">
                                <%
                                ResultSet rs2 = statement2.executeQuery
                                ("SELECT * FROM category");

                                 while(rs2.next()){ %>
                                <option><%= rs2.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><input value="" name="COURSE" size="20"></th>
                            <th><select name="DEGREE_NAME">
                                <%
                                ResultSet rs1 = statement1.executeQuery
                                ("SELECT DISTINCT DEGREE_NAME FROM degree");

                                 while(rs1.next()){ %>
                                <option><%= rs1.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><select name="DEGREE_TYPE">
                                <%
                                ResultSet rs3 = statement3.executeQuery
                                ("SELECT DISTINCT DEGREE_TYPE FROM degree");

                                 while(rs3.next()){ %>
                                <option><%= rs3.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="catList.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the CATE_NAME --%>
                            <td>
                            <input value="<%= rs.getString("CATE_NAME") %>"
                                name="CATE_NAME" size="20">
                            </td>

                            <%-- Get the PREREQ_ID --%>
                            <td>
                                <input value="<%= rs.getString("COURSE") %>"
                                    name="COURSE" size="20">
                            </td>

                            <%-- Get the DEGREE_NAME --%>
                            <td>
                                <input value="<%= rs.getString("DEGREE_NAME") %>"
                                    name="DEGREE_NAME" size="20">
                            </td>

                            <%-- Get the DEGREE_TYPE --%>
                            <td>
                                <input value="<%= rs.getString("DEGREE_TYPE") %>"
                                    name="DEGREE_TYPE" size="20">
                            </td>


                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="catList.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getString("CATE_NAME") %>" name="CATE_NAME">
                            <input type="hidden"
                                value="<%= rs.getString("COURSE") %>" name="COURSE">
                            <input type="hidden"
                                value="<%= rs.getString("DEGREE_NAME") %>" name="DEGREE_NAME">
                            <input type="hidden"
                                value="<%= rs.getString("DEGREE_TYPE") %>" name="DEGREE_TYPE">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
                    rs1.close();
                    rs2.close();
                    rs3.close();
                    // Close the Statement
                    statement.close();
                    statement1.close();
                    statement2.close();
                    statement3.close();
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
