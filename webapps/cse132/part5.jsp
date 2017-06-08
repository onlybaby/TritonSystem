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
                    Statement statement4 = conn.createStatement();
                    Statement statement5 = conn.createStatement();
                    Statement statement6 = conn.createStatement();
                    Statement statement7 = conn.createStatement();
                    Statement statement8 = conn.createStatement();
                    Statement statement9 = conn.createStatement();
                    Statement statement10 = conn.createStatement();
                    Statement statement11 = conn.createStatement();
                    Statement statement12 = conn.createStatement();
                    Statement statement13 = conn.createStatement();
                    Statement statement14 = conn.createStatement();
                    Statement statement15 = conn.createStatement();
                    Statement statement16 = conn.createStatement();
                    Statement statement17 = conn.createStatement();
                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT CLASS_ID, course_id, INSTRUCTOR, QUARTER, YEAR FROM class");
                    ResultSet rs1 = statement1.executeQuery
                        ("SELECT distinct QUARTER, YEAR FROM class");




            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">


                    <tr>
                        <th>Course By Professor</th>
                        <th>Tuanght QUARTER And Year</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="part5.jsp" method="get">
                            <input type="hidden" value="select_Info" name="action">

                            <th><select name="COURSE_ID">
                                <%  while(rs.next()){ %>
                                <option value ="<%= rs.getString("COURSE_ID") + "," + rs.getString("INSTRUCTOR")%>"> <%= rs.getString("COURSE_ID") + " By " + rs.getString("INSTRUCTOR") %></option>
                                <% } %>
                            </select></th>

                            <th><select name="TAUGHT_QUARTER">
                                <%  while(rs1.next()){ %>
                                <option value ="<%= rs1.getString("QUARTER")+ "," + rs1.getString("YEAR")%>"> <%= rs1.getString("QUARTER") + " " + rs1.getString("YEAR") %></option>
                                <% } %>
                            </select></th>
                            <th><input type="submit" value="select_Info"></th>
                        </form>
                    </tr>
                    </table>
                    <table border = "5">
                    <tr>
                        <td>Grade Distribution</td>
                    </tr>
                    <tr>
                        <th>Course</th>
                        <th>Professor</th>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Grade</th>
                        <th>Count Of Grade</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    String[] values = request.getParameter("TAUGHT_QUARTER").split(",");
                    String[] values1 = request.getParameter("COURSE_ID").split(",");
                    ResultSet rs2 = statement2.executeQuery
                        ("SELECT * FROM CPQG");


                    // rs.close();
                    //
                    // rs = statement.executeQuery
                    //     ("SELECT * FROM enroll_current");
                    while ( rs2.next() ) {

            %>

                    <tr>
                        <form action="part5.jsp" method="post">


                            <%-- Get the Professor --%>
                            <td>
                              <%= rs2.getString(1) %>
                            </td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs2.getString(2) %>
                            </td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs2.getString(3) %>
                            </td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs2.getString(4) %>
                            </td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs2.getString(5) %>
                            </td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs2.getString(6) %>
                            </td>

                        </form>
                    </tr>
            <%
                    }
            %>


    <tr>
        <td>Grade Distribution Over The Years</td>
    </tr>
    <tr>
    <th>Course</th>
    <th>Professor</th>
    <th>Grade</th>
    <th>Count Of Grade</th>
    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    ResultSet rs3 = statement3.executeQuery
                        ("SELECT * FROM CPG");


                    // rs.close();
                    //
                    // rs = statement.executeQuery
                    //     ("SELECT * FROM enroll_current");
                    while ( rs3.next() ) {

            %>

                    <tr>
                        <form action="part5.jsp" method="post">


                            <%-- Get the Professor --%>
                            <td>
                              <%= rs3.getString(1) %>
                            </td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs3.getString(2) %>
                            </td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs3.getString(3) %>
                            </td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs3.getString(4) %>
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
                    rs2.close();
                    rs3.close();
                    // rs4.close();
                    // rs5.close();
                    // rs6.close();

                    // Close the Statement
                    statement.close();
                    statement1.close();
                    statement2.close();
                    statement3.close();
                    // statement4.close();
                    // statement5.close();
                    // statement6.close();
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
