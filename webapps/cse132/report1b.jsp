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
                    Statement statement2 = conn.createStatement();
                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT distinct c.course_id, cl.quarter, cl.year FROM class cl INNER JOIN course c ON cl.course_id = c.course_id WHERE cl.QUARTER = 'sp' AND cl.YEAR = 2017 ");



            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">


                    <tr>
                        <th>Course Title</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="report1b.jsp" method="get">
                            <input type="hidden" value="select_course" name="action">

                            <th><select name="COURSE_TITLE">
                                <%  while(rs.next()){ %>
                                <option value ="<%= rs.getString("COURSE_ID")%>"> <%= rs.getString("COURSE_ID") + " " + rs.getString("QUARTER") + " " + rs.getInt("YEAR") %></option>
                                <% } %>
                            </select></th>
                            <th><input type="submit" value="select_course"></th>
                        </form>
                    </tr>

                    <tr></tr>
                  </table>
                  <table border = "5">
                    <tr align="center">
                        <td>Enrollment Information</td>
                    </tr>
                    <tr></tr>
                    <tr></tr>
                    <tr>
                        <th>PID</th>
                        <th>SSN</th>
                        <th>First Name</th>
                        <th>Middle Name</th>
			                  <th>Last Name</th>
                        <th>Residency</th>
                        <th>Enrollment</th>
                        <th>Grade Option</th>
                        <th>Units</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    ResultSet rs2 = statement2.executeQuery
                        ("SELECT distinct s.*, e.GRADE_OPTION, e.UNIT FROM Student s INNER JOIN enroll_current e ON s.ID = e.PID WHERE e.COURSE_ID = '" + request.getParameter("COURSE_TITLE") + "'");

                    // rs.close();
                    //
                    // rs = statement.executeQuery
                    //     ("SELECT * FROM enroll_current");

                    while ( rs2.next() ) {

            %>

                    <tr>
                        <form action="report1b.jsp" method="post">


                            <%-- Get the STUDENT ID --%>
                            <td>
                              <%= rs2.getInt("ID") %>
                            </td>

                            <%-- Get the STUDENT SSN --%>
                            <td>
                              <%= rs2.getInt("SSN") %>
                            </td>
                              <%-- Get the FIRST NAME --%>
                            <td>
                              <%= rs2.getString("FIRSTNAME") %>
                            </td>
                              <%-- Get the MIDDLENAME --%>
                            <td>
                              <%= rs2.getString("MIDDLENAME") %>
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <%= rs2.getString("LASTNAME") %>
                            </td>

                            <%-- Get the Residency --%>
                            <td>
                                <%= rs2.getString("RESIDENCY") %>
                            </td>

                            <%-- Get the ENROLLMENT --%>
                            <td>
                                <%= rs2.getString("ENROLLMENT") %>
                            </td>
                            <td>
                                <%= rs2.getString("GRADE_OPTION") %>
                            </td>
                            <td>
                                <%= rs2.getInt("UNIT") %>
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
