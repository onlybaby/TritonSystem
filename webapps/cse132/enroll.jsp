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
                            "INSERT INTO enroll_current VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(2, request.getParameter("COURSE_ID"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setString(4, request.getParameter("GRADE_OPTION"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("UNIT")));
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
                            "UPDATE enroll_current SET course_id = ?, grade_option = ?, " +
                            "unit = ? " +
                            "WHERE CLASS_ID = ? AND PID = ?");

                        pstmt.setString(1, request.getParameter("COURSE_ID"));
                        pstmt.setString(2, request.getParameter("GRADE_OPTION"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("UNIT")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("PID")));
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
                            "DELETE FROM enroll_current WHERE CLASS_ID = ? AND PID = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("PID")));
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
                        ("SELECT * FROM course");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">


                    <tr>
                        <th>Course_id</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="enroll.jsp" method="get">
                            <input type="hidden" value="getCID" name="action">

                            <th><select name="COURSE_ID">
                                <%  while(rs.next()){ %>
                                <option><%= rs.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><input type="submit" value="getCID"></th>
                        </form>
                    </tr>

                    <tr>
                        <th>Course_id</th>
                        <th>Class_id</th>
                        <th>PID</th>
                        <th>GRADE_OPTION</th>
			                  <th>UNIT</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="enroll.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value = <%= request.getParameter("COURSE_ID")%> name = "COURSE_ID" size="10"></th>
                            <th><select name="CLASS_ID">
                                <%

                                ResultSet rs2 = statement2.executeQuery
                                ("SELECT * FROM class WHERE course_id = '" + request.getParameter("COURSE_ID") + "' and quarter = 'SPRING' and year = '2017'");

                                 while(rs2.next()){ %>
                                <option><%= rs2.getInt(1)%></option>
                                <% } %>
                            </select></th>
                            <th><input value="" name="PID" size="10"></th>
                            <th><select name="GRADE_OPTION">
                                <option value="ANY">ANY</option>
                                <option value="LETTER">LETTER</option>
                                <option value="S/U">S/U</option>
                            </select></th>
			                <th><select name="UNIT">
                                <%
                                ResultSet rs3 = statement.executeQuery
                                ("SELECT * FROM course WHERE course_id = '" + request.getParameter("COURSE_ID") + "'");

                                 while(rs3.next()){

                                 for ( int i = rs3.getInt(3); i < rs3.getInt(4)+1; i++){%>
                                <option><%= i%></option>
                                <% } }%>
                            </select></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    rs.close();

                    rs = statement.executeQuery
                        ("SELECT * FROM enroll_current");

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="enroll.jsp" method="get">
                            <input type="hidden" value="update" name="action">


                            <%-- Get the COURSE_ID --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_ID") %>"
                                    name="COURSE_ID" size="10">
                            </td>


                            <%-- Get the CLASS_ID --%>
                            <td>
                                <input value="<%= rs.getInt("CLASS_ID") %>"
                                    name="CLASS_ID" size="10">
                            </td>


                            <%-- Get the PID --%>
                            <td>
                                <input value="<%= rs.getInt("PID") %>"
                                    name="PID" size="15">
                            </td>

                            <%-- Get the GRADE_OPTION --%>
                            <td>
                                <input value="<%= rs.getString("GRADE_OPTION") %>"
                                    name="GRADE_OPTION" size="15">
                            </td>

                            <%-- Get the UNIT --%>
                            <td>
                                <input value="<%= rs.getInt("UNIT") %>"
                                    name="UNIT" size="15">
                            </td>


                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="enroll.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("CLASS_ID") %>" name="CLASS_ID">
                            <input type="hidden"
                                value="<%= rs.getInt("PID") %>" name="PID">
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
                    rs3.close();

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
