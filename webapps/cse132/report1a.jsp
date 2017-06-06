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

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT Distinct s.* FROM student s, enroll_current e where s.id = e.pid ORDER BY s.id");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">


                    <tr>
                        <th>Student</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="report1a.jsp" method="get">
                            <input type="hidden" value="Select_Student" name="action">

                            <th><select name="ID">
                                <%  while(rs.next()){ %>
                                <option value="<%= rs.getString(1)%>" > <%= rs.getString(1) + ", " + rs.getString(3) + ", " + rs.getString(4) + ", " + rs.getString(5) %></option>
                                <% } %>
                            </select></th>
                            <th><input type="submit" value="Select_Student"></th>
                        </form>
                    </tr>

                    <tr>
                        <th>Course Title</th>
                        <th>Course Number</th>
                        <th>Quaters Offered</th>
                        <th>Currently Taught</th>
                        <th>Next Offered Quarter</th>
                        <th>Units</th>
                        <th>Section</th>
                    </tr>


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    ResultSet rs2;

                    rs2 = statement.executeQuery("SELECT * FROM course ");



                    if (request.getParameter("ID") != null){

                    rs2 = statement.executeQuery
                        ("SELECT c.*, e.* , o.* FROM course c INNER JOIN quarter_offered o ON c.course_id = o.course_id FULL JOIN enroll_current e ON o.course_id = e.course_id WHERE pid = '" + request.getParameter("ID") + "'" );



                    while ( rs2.next() ) {

            %>

                    <tr>
                        <form action="report1a.jsp" method="post">


                            <%-- Get the COURSE_TITLE --%>
                            <td>
                                <%= rs2.getString("COURSE_NAME") %>
                            </td>


                            <%-- Get the COURSE_NUMBER --%>
                            <td>
                                <%= rs2.getString("COURSE_ID") %>
                            </td>


                            <%-- Get the QUARTER_OFFERED --%>
                            <td>
                                <%= rs2.getString("OFFERED_QUARTER") %>
                            </td>

                            <%-- Get the CURRENTLY_TAUGHT --%>
                            <td>
                                <%= rs2.getString("CURRENT_TAUGHT") %>
                            </td>

                            <%-- Get the NEXT_OFFERED_QUARTER --%>
                            <td>
                                <%= rs2.getString("NEXT_QUARTER") + " " + rs2.getString("NEXT_YEAR") %>
                            </td>


                            <%-- Get the UNITS --%>
                            <td>
                                <%= rs2.getInt("UNIT") %>
                            </td>

                            <%-- Get the SECTION --%>
                            <td>
                                <%= rs2.getString("CLASS_ID") %>
                            </td>


                        </form>
                    </tr>
            <%
                }
            }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
                    rs2.close();

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
