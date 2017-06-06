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
                            "INSERT INTO concentration_list VALUES (?, ?)");

                            pstmt.setString(1, request.getParameter("CON_NAME"));
                            pstmt.setString(2, request.getParameter("COURSE"));
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
                            "UPDATE concentration_list SET CON_NAME = ?, COURSE = ?");

                            pstmt.setString(1, request.getParameter("CON_NAME"));
                            pstmt.setString(2, request.getParameter("COURSE"));
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
                            "DELETE FROM concentration_list WHERE CON_NAME = ? AND COURSE = ?");

                            pstmt.setString(1, request.getParameter("CON_NAME"));
                            pstmt.setString(2, request.getParameter("COURSE"));
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
                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM concentration_list");
            %>


            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Concentration Name</th>
                        <th>Course</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="conList.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><select name="CON_NAME">
                                <%
                                ResultSet rs2 = statement2.executeQuery
                                ("SELECT * FROM concentration");

                                 while(rs2.next()){ %>
                                <option><%= rs2.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><input value="" name="COURSE" size="20"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="conList.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the CON_NAME --%>
                            <td>
                            <input value="<%= rs.getString("CON_NAME") %>"
                                name="CON_NAME" size="20">
                            </td>

                            <%-- Get the COURSE --%>
                            <td>
                                <input value="<%= rs.getString("COURSE") %>"
                                    name="COURSE" size="20">
                            </td>


                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="catList.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getString("CON_NAME") %>" name="CON_NAME">
                            <input type="hidden"
                                value="<%= rs.getString("COURSE") %>" name="COURSE">
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
                    rs2.close();
                    // Close the Statement
                    statement.close();
                    statement2.close();
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
