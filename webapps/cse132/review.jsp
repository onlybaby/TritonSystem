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
                            "INSERT INTO review_sessions VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(2, request.getParameter("DATE"));
                        pstmt.setString(3, request.getParameter("TIME"));
                        pstmt.setString(4, request.getParameter("ROOM"));
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
                            "UPDATE review_sessions SET CLASS_ID = ?, DATE = ?, " +
                            "TIME = ?, ROOM = ? " +
                            "WHERE CLASS_ID = ? AND DATE = ? AND TIME = ? AND ROOM = ?");

                            pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                            pstmt.setString(2, request.getParameter("DATE"));
                            pstmt.setString(3, request.getParameter("TIME"));
                            pstmt.setString(4, request.getParameter("ROOM"));
                            pstmt.setInt(5, Integer.parseInt(request.getParameter("CLASS_ID")));
                            pstmt.setString(6, request.getParameter("DATE"));
                            pstmt.setString(7, request.getParameter("TIME"));
                            pstmt.setString(8, request.getParameter("ROOM"));
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
                            "DELETE FROM review_sessions WHERE CLASS_ID = ? AND DATE = ? AND TIME = ? AND ROOM = ?");

                            pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                            pstmt.setString(2, request.getParameter("DATE"));
                            pstmt.setString(3, request.getParameter("TIME"));
                            pstmt.setString(4, request.getParameter("ROOM"));
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

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM review_sessions");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>CLASS_ID</th>
                        <th>DATE</th>
                        <th>TIME</th>
			                  <th>ROOM</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="review.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CLASS_ID" size="10"></th>
                            <th><input value="" name="DATE" size="15"></th>
			                      <th><input value="" name="TIME" size="15"></th>
                            <th><input value="" name="ROOM" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="review.jsp" method="get">
                            <input type="hidden" value="update" name="action">


                            <%-- Get the CLASS_ID --%>
                            <td>
                                <input value="<%= rs.getInt("CLASS_ID") %>"
                                    name="CLASS_ID" size="10">
                            </td>


                            <%-- Get the DATE --%>
                            <td>
                                <input value="<%= rs.getString("DATE") %>"
                                    name="DATE" size="10">
                            </td>


                            <%-- Get the TIME --%>
                            <td>
                                <input value="<%= rs.getString("TIME") %>"
                                    name="TIME" size="15">
                            </td>

                            <%-- Get the ROOM --%>
                            <td>
                                <input value="<%= rs.getString("ROOM") %>"
                                    name="ROOM" size="15">
                            </td>



                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="review.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("CLASS_ID") %>" name="CLASS_ID">
                            <input type="hidden"
                                value="<%= rs.getString("DATE") %>" name="DATE">
                            <input type="hidden"
                                value="<%= rs.getString("TIME") %>" name="TIME">
                            <input type="hidden"
                                value="<%= rs.getString("ROOM") %>" name="ROOM">
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

                    // Close the Statement
                    statement.close();

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
