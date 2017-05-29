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
                            "INSERT INTO course VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("COURSE_ID"));
                        pstmt.setString(2, request.getParameter("COURSE_NAME"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("MIN_UNIT")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("MAX_UNIT")));
                        pstmt.setString(5, request.getParameter("DEPT"));
                        pstmt.setString(6, request.getParameter("GRADE_OPTION"));
                        pstmt.setString(7, request.getParameter("LAB_REQUIRED"));
                        pstmt.setString(8, request.getParameter("INSTRUCTOR_CONSENT"));
                        pstmt.setString(9, request.getParameter("CURRENT_TAUGHT"));
                        pstmt.setString(10, request.getParameter("NEXT_QUARTER"));
                        pstmt.setInt(11, Integer.parseInt(request.getParameter("NEXT_YEAR")));
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
                            "UPDATE COURSE SET COURSE_NAME = ?, MIN_UNIT = ?,MAX_UNIT = ?, DEPT = ?, GRADE_OPTION = ?, LAB_REQUIRED = ?, INSTRUCTOR_CONSENT = ?, CURRENT_TAUGHT = ?, NEXT_QUARTER = ?, NEXT_YEAR = ? WHERE COURSE_ID = ?");


                        pstmt.setString(1, request.getParameter("COURSE_NAME"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MIN_UNIT")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("MAX_UNIT")));
                        pstmt.setString(4, request.getParameter("DEPT"));
                        pstmt.setString(5, request.getParameter("GRADE_OPTION"));
                        pstmt.setString(6, request.getParameter("LAB_REQUIRED"));
                        pstmt.setString(7, request.getParameter("INSTRUCTOR_CONSENT"));
                        pstmt.setString(8, request.getParameter("CURRENT_TAUGHT"));
                        pstmt.setString(9, request.getParameter("NEXT_QUARTER"));
                        pstmt.setInt(10, Integer.parseInt(request.getParameter("NEXT_YEAR")));
                        pstmt.setString(11, request.getParameter("COURSE_ID"));
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
                            "DELETE FROM Course WHERE COURSE_ID = ?");

                        pstmt.setString(1, request.getParameter("COURSE_ID"));
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
                    Statement statement1 = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Course");
                    ResultSet rs1 = statement1.executeQuery
                        ("SELECT * FROM Dept");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course_id</th>
                        <th>Course_name</th>
                        <th>Min_unit</th>
			                  <th>Max_unit</th>
                        <th>Dept</th>
                        <th>Grade_option</th>
                        <th>Lab_required</th>
                        <th>Instructor_consent</th>
                        <th>Currently Taught</th>
                        <th>Next Offered Quarter</th>
                        <th>Next Offered Year</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="COURSE_ID" size="10"></th>
                            <th><input value="" name="COURSE_NAME" size="10"></th>
                            <th><input value="" name="MIN_UNIT" size="15"></th>
			                <th><input value="" name="MAX_UNIT" size="15"></th>
                            <th><select name="DEPT">
                                <%  while(rs1.next()){ %>
                                <option><%= rs1.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><select name="GRADE_OPTION">
                                <option value="ANY">ANY</option>
                                <option value="LETTER">LETTER</option>
                                <option value="S/U">S/U</option>
                            </select></th>
                            <th><select name="LAB_REQUIRED">
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>
                            </select></th>
                            <th><select name="INSTRUCTOR_CONSENT">
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>
                            </select></th>
                            <th><select name="CURRENT_TAUGHT">
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>
                            </select></th>
                            <th><select name="NEXT_QUARTER">
                                <option value="SPRING">SPRING</option>
                                <option value="SUMMER">SUMMER</option>
                                <option value="FALL">FALL</option>
                                <option value="WINTER">WINTER</option>
                            </select></th>
                            <th><input value="" name="NEXT_YEAR" size="10"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the COURSE_ID --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_ID") %>"
                                    name="COURSE_ID" size="10">
                            </td>

                            <%-- Get the COURSE_NAME --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_NAME") %>"
                                    name="COURSE_NAME" size="10">
                            </td>

                            <%-- Get the MIN_UNIT --%>
                            <td>
                                <input value="<%= rs.getInt("MIN_UNIT") %>"
                                    name="MIN_UNIT" size="15">
                            </td>

                            <%-- Get the MAX_UNIT --%>
                            <td>
                                <input value="<%= rs.getInt("MAX_UNIT") %>"
                                    name="MAX_UNIT" size="15">
                            </td>

                            <%-- Get the DEPT --%>
                            <td>
                                <input value="<%= rs.getString("DEPT") %>"
                                    name="DEPT" size="15">
                            </td>

			                <%-- Get the GRADE_OPTION --%>
                            <td>
                                <input value="<%= rs.getString("GRADE_OPTION") %>"
                                    name="GRADE_OPTION" size="15">
                            </td>

                            <%-- Get the LAB_REQUIRED --%>
                            <td>
                                <input value="<%= rs.getString("LAB_REQUIRED") %>"
                                    name="LAB_REQUIRED" size="15">
                            </td>

                            <%-- Get the INSTRUCTOR_CONSENT --%>
                            <td>
                                <input value="<%= rs.getString("INSTRUCTOR_CONSENT") %>"
                                    name="INSTRUCTOR_CONSENT" size="15">
                            </td>

                            <%-- Get the CURRENT_TAUGHT --%>
                            <td>
                                <input value="<%= rs.getString("CURRENT_TAUGHT") %>"
                                    name="CURRENT_TAUGHT" size="15">
                            </td>

                            <%-- Get the NEXT_QUARTER --%>
                            <td>
                                <input value="<%= rs.getString("NEXT_QUARTER") %>"
                                    name="NEXT_QUARTER" size="15">
                            </td>

                            <%-- Get the NEXT_YEAR --%>
                            <td>
                                <input value="<%= rs.getInt("NEXT_YEAR") %>"
                                    name="NEXT_YEAR" size="15">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getString("COURSE_ID") %>" name="COURSE_ID">
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

                    // Close the Statement
                    statement.close();
                    statement1.close();

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
