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
                    String dbURL = "jdbc:postgresql:cse132?user=postgres&password=admin";
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
                            "INSERT INTO weekly_meetings VALUES (?, ?, ?, ?, CAST (? AS time), CAST (? AS time), ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(2, request.getParameter("REQUIRED"));
                        pstmt.setString(3, request.getParameter("TYPE"));
                        pstmt.setString(4, request.getParameter("DAY_WEEKLY"));
                        pstmt.setString(5, request.getParameter("START_WEEKLY"));
                        pstmt.setString(6, request.getParameter("END_WEEKLY"));
                        pstmt.setString(7, request.getParameter("ROOM_WEEKLY"));
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
                            "UPDATE weekly_meetings SET class_id = ?, required = ?, " +
                            "type = ?, day_weekly = ?, start_weekly = CAST (? AS time) , end_weekly = CAST (? AS time), room_weekly = ? " +
                            "WHERE CLASS_ID = ? AND DAY_WEEKLY = ? AND START_WEEKLY = CAST (? AS time) AND END_WEEKLY = CAST (? AS time) AND ROOM_WEEKLY = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(2, request.getParameter("REQUIRED"));
                        pstmt.setString(3, request.getParameter("TYPE"));
                        pstmt.setString(4, request.getParameter("DAY_WEEKLY"));
                        pstmt.setString(5, request.getParameter("START_WEEKLY"));
                        pstmt.setString(6, request.getParameter("END_WEEKLY"));
                        pstmt.setString(7, request.getParameter("ROOM_WEEKLY"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("OLD_CLASS_ID")));
                        pstmt.setString(9, request.getParameter("OLD_DAY_WEEKLY"));
                        pstmt.setString(10, request.getParameter("OLD_START_WEEKLY"));
                        pstmt.setString(11, request.getParameter("OLD_END_WEEKLY"));
                        pstmt.setString(12, request.getParameter("OLD_ROOM_WEEKLY"));

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
                            "DELETE FROM weekly_meetings WHERE CLASS_ID = ? AND DAY_WEEKLY = ? AND START_WEEKLY = CAST (? AS time) AND END_WEEKLY = CAST (? AS time) AND ROOM_WEEKLY = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(2, request.getParameter("DAY_WEEKLY"));
                        pstmt.setString(3, request.getParameter("START_WEEKLY"));
                        pstmt.setString(4, request.getParameter("END_WEEKLY"));
                        pstmt.setString(5, request.getParameter("ROOM_WEEKLY"));

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
                        ("SELECT * FROM weekly_meetings order by class_id");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">



                    <tr>
                        <th>Class_id</th>
                        <th>required</th>
                        <th>type</th>
                        <th>day</th>
			            <th>start</th>
                        <th>end</th>
                        <th>room</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="weekly.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CLASS_ID" size="10"></th>
                            <th><input value="" name="REQUIRED" size="10"></th>
                            <th><input value="" name="TYPE" size="10"></th>
                            <th><input value="" name="DAY_WEEKLY" size="10"></th>
			                <th><input value="" name="START_WEEKLY" size="10"></th>
                            <th><input value="" name="END_WEEKLY" size="10"></th>
                            <th><input value="" name="ROOM_WEEKLY" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="weekly.jsp" method="get">
                            <input type="hidden" value="update" name="action">


                            <%-- Get the CLASS_ID --%>
                            <td>
                                <input value="<%= rs.getInt("CLASS_ID") %>"
                                    name="CLASS_ID" size="10">
                            </td>


                            <%-- Get the REQUIRED --%>
                            <td>
                                <input value="<%= rs.getString("REQUIRED") %>"
                                    name="REQUIRED" size="10">
                            </td>


                            <%-- Get the TYPE --%>
                            <td>
                                <input value="<%= rs.getString("TYPE") %>"
                                    name="TYPE" size="15">
                            </td>

                            <%-- Get the DAY_WEEKLY --%>
                            <td>
                                <input value="<%= rs.getString("DAY_WEEKLY") %>"
                                    name="DAY_WEEKLY" size="15">
                            </td>

                            <%-- Get the START_WEEKLY --%>
                            <td>
                                <input value="<%= rs.getString("START_WEEKLY") %>"
                                    name="START_WEEKLY" size="15">
                            </td>

                            <%-- Get the END_WEEKLY --%>
                            <td>
                                <input value="<%= rs.getString("END_WEEKLY") %>"
                                    name="END_WEEKLY" size="10">
                            </td>

                            <%-- Get the ROOM_WEEKLY --%>
                            <td>
                                <input value="<%= rs.getString("ROOM_WEEKLY") %>"
                                    name="ROOM_WEEKLY" size="10">
                            </td>

                            <input type="hidden"
                                value="<%= rs.getInt("CLASS_ID") %>" name="OLD_CLASS_ID">
                            <input type="hidden"
                                value="<%= rs.getString("DAY_WEEKLY") %>" name="OLD_DAY_WEEKLY">
                            <input type="hidden"
                                value="<%= rs.getString("START_WEEKLY") %>" name="OLD_START_WEEKLY">
                            <input type="hidden"
                                value="<%= rs.getString("END_WEEKLY") %>" name="OLD_END_WEEKLY">
                            <input type="hidden"
                                value="<%= rs.getString("ROOM_WEEKLY") %>" name="OLD_ROOM_WEEKLY">

                            <%-- Button --%>

                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="weekly.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("CLASS_ID") %>" name="CLASS_ID">
                            <input type="hidden"
                                value="<%= rs.getString("DAY_WEEKLY") %>" name="DAY_WEEKLY">
                            <input type="hidden"
                                value="<%= rs.getString("START_WEEKLY") %>" name="START_WEEKLY">
                            <input type="hidden"
                                value="<%= rs.getString("END_WEEKLY") %>" name="END_WEEKLY">
                            <input type="hidden"
                                value="<%= rs.getString("ROOM_WEEKLY") %>" name="ROOM_WEEKLY">
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
