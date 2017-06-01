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
                    String dbURL = "jdbc:postgresql:cse132?user=postgres&password=admin";
                    Connection conn = DriverManager.getConnection(dbURL);

            %>


            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT Distinct s.* FROM student s, enroll_current e where s.id = e.pid");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    

                    <tr>
                        <th>Student</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="report2a.jsp" method="get">
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
                        <th>Course Number</th>
                        <th>Course Title</th>
                        <th>Conflict Number</th>
                        <th>Conflict Title</th>
                    </tr>
                    

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    ResultSet rs2;

                    rs2 = statement.executeQuery("SELECT * FROM course ");
                    

                    
                    if (request.getParameter("ID") != null){
                   
                    /*
                    rs2 = statement.executeQuery
                        ("SELECT CONFLICT_COURSE_ID, COUNT(CONFLICT_COURSE_ID) AS GET_CONFLICT_COUNT FROM (SELECT DISTINCT c1.course_id AS COURSE_ID, c1.course_name AS COURSE_NAME, cl1.class_id AS CLASS_ID, c2.course_id AS CONFLICT_COURSE_ID, c2.course_name AS CONFLICT_COURSE_NAME, cl2.class_id AS CONFLICT_CLASS_ID FROM course c1, course c2, class cl1, class cl2, weekly_meetings w1, weekly_meetings w2, enroll_current e WHERE c1.course_id = cl1.course_id AND c2.course_id = cl2.course_id AND w1.class_id = cl1.class_id AND w2.class_id = cl2.class_id AND e.class_id = cl1.class_id AND w1.day_weekly = w2.day_weekly AND ((w1.start_weekly > w2.start_weekly AND w1.start_weekly < w2.end_weekly) OR (w1.end_weekly > w2.start_weekly AND w1.end_weekly < w2.end_weekly)) AND e.pid = '" + request.getParameter("ID") +"') AS temp GROUP BY CONFLICT_COURSE_ID");
                    */

                    
                    /*
                    rs2 = statement.executeQuery( "SELECT c.course_id AS GET_COURSE_ID, COUNT(c.course_id) AS GET_COUNT FROM enroll_current e, class cl, course c WHERE cl.course_id = c.course_id AND e.pid = '" + request.getParameter("ID") +"' GROUP BY c.course_id");
                    
                    */
                    
                    

                    rs2 = statement.executeQuery("SELECT CONFLICT.* FROM((SELECT COURSE_ID, CONFLICT_COURSE_ID, COUNT(CONFLICT_COURSE_ID) AS GET_CONFLICT_COUNT FROM (SELECT DISTINCT c1.course_id AS COURSE_ID, c1.course_name AS COURSE_NAME, cl1.class_id AS CLASS_ID, c2.course_id AS CONFLICT_COURSE_ID, c2.course_name AS CONFLICT_COURSE_NAME, cl2.class_id AS CONFLICT_CLASS_ID FROM course c1, course c2, class cl1, class cl2, weekly_meetings w1, weekly_meetings w2, enroll_current e WHERE c1.course_id = cl1.course_id AND c2.course_id = cl2.course_id AND w1.class_id = cl1.class_id AND w2.class_id = cl2.class_id AND e.class_id = cl1.class_id AND w1.day_weekly = w2.day_weekly AND ((w1.start_weekly > w2.start_weekly AND w1.start_weekly < w2.end_weekly) OR (w1.end_weekly > w2.start_weekly AND w1.end_weekly < w2.end_weekly) OR (w1.start_weekly = w2.start_weekly AND w1.end_weekly = w2.end_weekly)) AND e.pid = '" + request.getParameter("ID") +"') AS temp GROUP BY COURSE_ID, CONFLICT_COURSE_ID) AS TEMP1 INNER JOIN (SELECT c.course_id AS GET_COURSE_ID, COUNT(c.course_id) AS GET_COUNT FROM enroll_current e, class cl, course c WHERE cl.course_id = c.course_id AND e.pid = '" + request.getParameter("ID") +"' GROUP BY c.course_id) AS TEMP2 ON (TEMP1.GET_CONFLICT_COUNT = TEMP2.GET_COUNT AND TEMP1.CONFLICT_COURSE_ID = TEMP2.GET_COURSE_ID))AS CONFLICT");

                    


                    while ( rs2.next() ) {
        
            %>

                    <tr>
                        <form action="report2a.jsp" method="post">


                            <%-- Get the COURSE_NUMBER --%>
                            <td>
                                <%= rs2.getString(1) %>
                            </td>


                            <%-- Get the COURSE_TITLE --%>
                            <td>
                                <%= rs2.getString(1) %>
                            </td>
    
    
                            <%-- Get the CONFLICT_NUMBER --%>
                            <td>
                                <%= rs2.getString(2) %>
                            </td>
    
                            <%-- Get the CONFLICT_TITLE --%>
                            <td>
                                <%= rs2.getString(2) %>
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
