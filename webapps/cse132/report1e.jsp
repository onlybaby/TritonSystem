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

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();
                    Statement statement1 = conn.createStatement();
                    Statement statement2 = conn.createStatement();
                    Statement statement3 = conn.createStatement();
                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT s.* FROM Student s INNER JOIN Grad g on s.ID = g.PID WHERE s.enrollment = 'YES'");
                    ResultSet rs1 = statement1.executeQuery
                        ("SELECT distinct * FROM degree WHERE DEGREE_TYPE = 'MS'");



            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">


                    <tr>
                        <th>Student</th>
                        <th>Degree Name/Type</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="report1e.jsp" method="get">
                            <input type="hidden" value="select_Info" name="action">

                            <th><select name="STUDENT">
                                <%  while(rs.next()){ %>
                                <option value ="<%= rs.getString("ID")%>"> <%= rs.getString("SSN") + " " + rs.getString("FIRSTNAME") + " " + rs.getString("MIDDLENAME") + " " + rs.getString("LASTNAME") %></option>
                                <% } %>
                            </select></th>
                            <th><select name="DEGREE_NAME/TYPE">
                                <%  while(rs1.next()){ %>
                                <option value ="<%= rs1.getString("DEGREE_NAME")%>"> <%= rs1.getString("DEGREE_NAME") + " IN " + rs1.getString("DEGREE_TYPE") %></option>
                                <% } %>
                            </select></th>
                            <th><input type="submit" value="select_Info"></th>
                        </form>
                    </tr>

                    <tr>
                        <th>Completed Concentrations</th>
                    </tr>
                    <tr>
                        <th>Concentration Name</th>

                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    ResultSet rs2 = statement2.executeQuery
                        ("SELECT distinct c.con_name " +
                        "from concentration_degree cd " +
                        "inner join concentration_list c " +
                        "on cd.con_name = c.con_name " +
                        "inner join enrolled_list e " +
                        "on c.course = e.COURSE_ID " +
                        "inner join GRADE_CONVERSION g ON e.GRADE_RECEIVED = g.LETTER_GRADE " +
                        "where cd.DEPT = '" + request.getParameter("DEGREE_NAME/TYPE") + "' and cd.degree_type = " + "'MS'and e.pid = '" + request.getParameter("STUDENT") + "' " +
                        "AND e.GRADE_OPTION != 'S/U' " +
                        "AND (cd.MIN_UNIT <= ( " +
                          "select sum(unit) " +
                          "from enrolled_list " +
                          "where COURSE_ID in ( " +
                            "select course " +
                            "from concentration_list " +
                            "where con_name = c.con_name) and pid = '" + request.getParameter("STUDENT") + "')) " +
                        "AND ((SELECT SUM(g.NUMBER_GRADE) FROM GRADE_CONVERSION g)/(SELECT COUNT(e.UNIT) FROM enrolled_list e)) >= cd.gpa " +
                        "group by c.con_name ");

                    // rs.close();
                    //
                    // rs = statement.executeQuery
                    //     ("SELECT * FROM enroll_current");

                    while ( rs2.next() ) {

            %>

                    <tr>
                        <form action="report1e.jsp" method="post">


                            <%-- Get the CON_NAME --%>
                            <td>
                              <%= rs2.getString(1) %>
                            </td>

                        </form>
                    </tr>
            <%
                    }
            %>

            <tr>
                <th>Not Completed Concentration Course </th>
            </tr>
            <tr>
                <th>Concentration Name</th>
                <th>Course Name</th>
                <th>Next Offered</th>
            </tr>

            <%-- -------- Iteration Code -------- --%>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
                    rs1.close();
                    rs2.close();
                    // rs3.close();

                    // Close the Statement
                    statement.close();
                    statement1.close();
                    statement2.close();
                    // statement3.close();
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
