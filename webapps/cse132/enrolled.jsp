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
                            "INSERT INTO enrolled_list VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setString(2, request.getParameter("COURSE_ID"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setString(4, request.getParameter("GRADE_OPTION"));
                        pstmt.setString(5, request.getParameter("GRADE_RECEIVED"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("UNIT")));
                        pstmt.setString(7, request.getParameter("QUARTER"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("YEAR")));
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
                            "UPDATE enrolled_list SET course_id = ?, grade_option = ?, grade_received = ?, " +
                            "unit = ?, quarter = ?, year = ? " +
                            "WHERE CLASS_ID = ? AND PID = ?");

                        pstmt.setString(1, request.getParameter("COURSE_ID"));
                        pstmt.setString(2, request.getParameter("GRADE_OPTION"));
                        pstmt.setString(3, request.getParameter("GRADE_RECEIVED"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UNIT")));
                        pstmt.setString(5, request.getParameter("QUARTER"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("YEAR")));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("CLASS_ID")));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("PID")));
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
                            "DELETE FROM enrolled_list WHERE CLASS_ID = ? AND PID = ?");

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
                    Statement statement3 = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM course");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">


                    <tr>
                        <th>Course_id</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="enrolled.jsp" method="get">
                            <input type="hidden" value="getCID" name="action">

                            <th><select name="COURSE_ID">
                                <%  while(rs.next()){ %>
                                <option><%= rs.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><select name="QUARTER">
                                <option value="SPRING">SPRING</option>
                                <option value="SUMMER">SUMMER</option>
                                <option value="FALL">FALL</option>
                                <option value="WINTER">WINTER</option>
                            </select></th>
                            <th><input value="" name="YEAR" size="10"></th>
                            <th><input type="submit" value="getCID"></th>
                        </form>
                    </tr>

                    <tr>
                        <th>Course_id</th>
                        <th>Class_id</th>
                        <th>PID</th>
                        <th>GRADE_OPTION</th>
                        <th>GRADE_RECEIVED</th>
			                  <th>Unit</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="enrolled.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value = <%= request.getParameter("COURSE_ID")%> name = "COURSE_ID" size="10"></th>
                            <th><select name="CLASS_ID">
                                <%

                                ResultSet rs2 = statement2.executeQuery
                                ("SELECT * FROM class WHERE course_id = '" + request.getParameter("COURSE_ID") + "' and quarter = '" + request.getParameter("QUARTER") + "' and year = '" + request.getParameter("YEAR")+ "'");

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
                            <th><input value="" name="GRADE_RECEIVED" size="10"></th>
			                <th><select name="UNIT">
                                <%
                                ResultSet rs3 = statement3.executeQuery
                                ("SELECT * FROM course WHERE course_id = '" + request.getParameter("COURSE_ID") + "'");

                                 while(rs3.next()){

                                 for ( int i = rs3.getInt(3); i < rs3.getInt(4)+1; i++){%>
                                <option><%= i%></option>
                                <% } }%>
                            </select></th>
                            <th><input value = <%= request.getParameter("QUARTER")%> name = "QUARTER" size="10"></th>
                            <th><input value = <%= request.getParameter("YEAR")%> name = "YEAR" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    rs.close();

                    rs = statement.executeQuery
                        ("SELECT * FROM enrolled_list");

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="enrolled.jsp" method="get">
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

                            <%-- Get the GRADE_RECEIVED --%>
                            <td>
                                <input value="<%= rs.getString("GRADE_RECEIVED") %>"
                                    name="GRADE_RECEIVED" size="15">
                            </td>

                            <%-- Get the UNIT --%>
                            <td>
                                <input value="<%= rs.getInt("UNIT") %>"
                                    name="UNIT" size="15">
                            </td>

                            <%-- Get the QUARTER --%>
                            <td>
                                <input value="<%= rs.getString("QUARTER") %>"
                                    name="QUARTER" size="15">
                            </td>


                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="enrolled.jsp" method="get">
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
