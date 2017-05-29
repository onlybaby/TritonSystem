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
                            "INSERT INTO class VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(2, request.getParameter("COURSE_ID"));
                        pstmt.setString(3, request.getParameter("INSTRUCTOR"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("ENROLLMENT_LIMIT")));
                        pstmt.setString(5, request.getParameter("QUARTER"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("YEAR")));
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
                            "UPDATE Class SET COURSE_ID = ?, INSTRUCTOR = ?, " +
                            "ENROLLMENT_LIMIT = ?, QUARTER = ?, YEAR = ?" +
                            "WHERE CLASS_ID = ?");

                        pstmt.setString(1, request.getParameter("COURSE_ID"));
                        pstmt.setString(2, request.getParameter("INSTRUCTOR"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("ENROLLMENT_LIMIT")));
                        pstmt.setString(4, request.getParameter("QUARTER"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("YEAR")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("CLASS_ID")));
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
                            "DELETE FROM Class WHERE CLASS_ID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
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
                        ("SELECT * FROM Course");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Class_id</th>
                        <th>Course_id</th>
                        <th>Instructor</th>
			                  <th>Enrollment_limit</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="class.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="CLASS_ID" size="10"></th>
                            <th><select name="COURSE_ID">
                                <%  while(rs.next()){ %>
                                <option><%= rs.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><input value="" name="INSTRUCTOR" size="15"></th>
			                      <th><input value="" name="ENROLLMENT_LIMIT" size="15"></th>
                            <th><select name="QUARTER">
                                <option value="SPRING">SPRING</option>
                                <option value="SUMMER">SUMMER</option>
                                <option value="FALL">FALL</option>
                                <option value="WINTER">WINTER</option>
                            </select></th>
                            <th><input value="" name="YEAR" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    rs.close();

                    rs = statement.executeQuery
                        ("SELECT * FROM Class");

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="class.jsp" method="get">
                            <input type="hidden" value="update" name="action">


                            <%-- Get the CLASS_ID --%>
                            <td>
                                <input value="<%= rs.getInt("CLASS_ID") %>"
                                    name="CLASS_ID" size="10">
                            </td>


                            <%-- Get the COURSE_ID --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_ID") %>"
                                    name="COURSE_ID" size="10">
                            </td>


                            <%-- Get the INSTRUCTOR --%>
                            <td>
                                <input value="<%= rs.getString("INSTRUCTOR") %>"
                                    name="INSTRUCTOR" size="15">
                            </td>

                            <%-- Get the ENROLLMENT_LIMIT --%>
                            <td>
                                <input value="<%= rs.getInt("ENROLLMENT_LIMIT") %>"
                                    name="ENROLLMENT_LIMIT" size="15">
                            </td>

                            <%-- Get the QUARTER --%>
                            <td>
                                <input value="<%= rs.getString("QUARTER") %>"
                                    name="QUARTER" size="15">
                            </td>

                            <%-- Get the YEAR --%>
                            <td>
                                <input value="<%= rs.getInt("YEAR") %>"
                                    name="YEAR" size="15">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="class.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("CLASS_ID") %>" name="CLASS_ID">
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
