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
                        ("SELECT s.* FROM Student s INNER JOIN Undergrad u on s.ID = u.PID WHERE s.enrollment = 'YES'");
                    ResultSet rs1 = statement1.executeQuery
                        ("SELECT distinct * FROM degree WHERE DEGREE_TYPE <> 'MS'");



            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">


                    <tr>
                        <th>Student</th>
                        <th>Degree Name/Type</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="report1d.jsp" method="get">
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
                  </table>
                  <table border = "5">

            <tr>
                <th>Category Requirements</th>
            </tr>
            <tr>
                <th>Category Name</th>
                <th>Units Left For Category</th>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    ResultSet rs3 = statement3.executeQuery
                        ("SELECT c.cate_name, case when (c.MIN_UNIT - (SELECT SUM(e.unit) FROM enrolled_list e INNER JOIN CATEGORY_LIST cl ON e.COURSE_ID = cl.course WHERE cl.cate_name = c.cate_name AND cl.degree_name = c.MAJOR AND cl.DEGREE_TYPE <> 'MS' and e.pid = '" + request.getParameter("STUDENT") + "')) IS NULL THEN c.MIN_UNIT ELSE (c.MIN_UNIT - (SELECT SUM(e.unit) FROM enrolled_list e INNER JOIN CATEGORY_LIST cl ON e.COURSE_ID = cl.course WHERE cl.cate_name = c.cate_name AND cl.degree_name = c.MAJOR AND cl.DEGREE_TYPE <> 'MS' and e.pid = '" + request.getParameter("STUDENT") + "')) END FROM category_degree c WHERE c.MAJOR = '" + request.getParameter("DEGREE_NAME/TYPE") + "' AND c.DEGREE_TYPE <> 'MS'");

                    // rs.close();
                    //
                    // rs = statement.executeQuery
                    //     ("SELECT * FROM enroll_current");
                    int unitsLeft = 0;

                    while ( rs3.next() ) {

            %>

                    <tr>
                        <form action="report1d.jsp" method="post">


                            <%-- Get the CATEGORY_NAME --%>
                            <td>
                              <%= rs3.getString(1) %>
                            </td>
                              <%-- Get the UNITS LEFT --%>
                            <td>
                              <%= rs3.getInt(2) %>
                            </td>

                        </form>
                    </tr>
            <%
                unitsLeft+= rs3.getInt(2);
                    }
            %>

            <tr align = "center">
                <td>Degree Requirements</td>
            </tr>
            <tr>
                <th>Degree Name</th>
                <th>Units Left For Degree</th>
            </tr>

    <%-- -------- Iteration Code -------- --%>
    <%
            // Iterate over the ResultSet
            ResultSet rs2 = statement2.executeQuery
                ("SELECT DEGREE_NAME, ((SELECT units FROM degree WHERE degree_name = '" + request.getParameter("DEGREE_NAME/TYPE")+ "' AND DEGREE_TYPE <> 'MS') - (SELECT SUM(unit) FROM enrolled_list WHERE COURSE_ID IN (SELECT course FROM CATEGORY_LIST WHERE degree_name = '" + request.getParameter("DEGREE_NAME/TYPE") + "'AND DEGREE_TYPE <> 'MS' AND PID = '" + request.getParameter("STUDENT") + "'))) FROM degree WHERE DEGREE_NAME = '" + request.getParameter("DEGREE_NAME/TYPE") + "' AND DEGREE_TYPE <> 'MS'");

            // rs.close();
            //
            // rs = statement.executeQuery
            //     ("SELECT * FROM enroll_current");

           while ( rs2.next() ) {

    %>

            <tr>
                <form action="report1d.jsp" method="post">


                    <%-- Get the DEGREE_NAME --%>
                    <td>
                      <%= request.getParameter("DEGREE_NAME/TYPE") %>
                    </td>
                      <%-- Get the UNITS LEFT --%>
                    <td>
                      <%= rs2.getString(2) %>
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
                    //rs2.close();
                    rs3.close();

                    // Close the Statement
                    statement.close();
                    statement1.close();
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
