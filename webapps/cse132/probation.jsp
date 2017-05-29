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
                            "INSERT INTO probation VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("CASE_ID")));
                        pstmt.setString(3, request.getParameter("START_QUARTER"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("START_YEAR")));
                        pstmt.setString(5, request.getParameter("END_QUARTER"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("END_YEAR")));
                        pstmt.setString(7, request.getParameter("REASON"));

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
                            "UPDATE probation SET PID = ?, START_QUARTER = ?, START_YEAR = ?, END_QUARTER = ?, END_YEAR = ?, EASON = ? WHERE CASE_ID = ?");


                        pstmt.setInt(1, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setString(2, request.getParameter("START_QUARTER"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("START_YEAR")));
                        pstmt.setString(4, request.getParameter("END_QUARTER"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("END_YEAR")));
                        pstmt.setString(6, request.getParameter("REASON"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("CASE_ID")));

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
                            "DELETE FROM probation WHERE case_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CASE_ID")));
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
                        ("SELECT * FROM probation");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>pid</th>
                        <th>case_id</th>
                        <th>start_quarter</th>
                        <th>start_year</th>
                        <th>end_quarter</th>
                        <th>end_year</th>
                        <th>reason</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="PID" size="10"></th>
                            <th><input value="" name="CASE_ID" size="10"></th>
                            <th><select name="START_QUARTER">
                                <option value="SPRING">SPRING</option>
                                <option value="SUMMER">SUMMER</option>
                                <option value="FALL">FALL</option>
                                <option value="WINTER">WINTER</option>
                            </select></th>
                            <th><input value="" name="START_YEAR" size="10"></th>
                            <th><select name="END_QUARTER">
                                <option value="SPRING">SPRING</option>
                                <option value="SUMMER">SUMMER</option>
                                <option value="FALL">FALL</option>
                                <option value="WINTER">WINTER</option>
                            </select></th>
                            <th><input value="" name="END_YEAR" size="10"></th>
                            <th><input value="" name="REASON" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the pid --%>
                            <td>
                                <input value="<%= rs.getInt("PID") %>"
                                    name="PID" size="10">
                            </td>


                            <%-- Get the CASE_ID --%>
                            <td>
                                <input value="<%= rs.getInt("CASE_ID") %>"
                                    name="CASE_ID" size="10">
                            </td>

                            <%-- Get the START_QUARTER --%>
                            <td>
                                <input value="<%= rs.getString("START_QUARTER") %>"
                                    name="START_QUARTER" size="10">
                            </td>

                            <%-- Get the START_YEAR --%>
                            <td>
                                <input value="<%= rs.getInt("START_YEAR") %>"
                                    name="START_YEAR" size="10">
                            </td>

                            <%-- Get the END_QUARTER --%>
                            <td>
                                <input value="<%= rs.getString("END_QUARTER") %>"
                                    name="END_QUARTER" size="10">
                            </td>

                            <%-- Get the END_YEAR --%>
                            <td>
                                <input value="<%= rs.getInt("END_YEAR") %>"
                                    name="END_YEAR" size="10">
                            </td>

                            <%-- Get the REASON --%>
                            <td>
                                <input value="<%= rs.getString("REASON") %>"
                                    name="REASON" size="10">
                            </td>


                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="probation.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("case_id") %>" name="case_id">
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
