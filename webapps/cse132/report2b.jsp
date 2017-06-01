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
                        ("SELECT e.class_id, c.course_id, c.course_name FROM course c, enroll_current e where c.course_id = e.course_id");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    

                    <tr>
                        <th>Section</th>
                        <th>Begin</th>
                        <th>End</th>
                        <th>Action</th>
                    </tr>

                    <tr>
                        <form action="report2b.jsp" method="get">
                            <input type="hidden" value="Select_Section" name="action">
                            
                            <th><select name="ID">
                                <%  while(rs.next()){ %>
                                <option value="<%= rs.getString(1)%>" > <%= rs.getString(1) + ", " + rs.getString(2) + ", " + rs.getString(3) %></option>
                                <% } %>
                            </select></th>
                            <th><select name="Begin">
                                <option value = 1>Mon</option>
                                <option value = 2>Tue</option>
                                <option value = 3>Wed</option>
                                <option value = 4>Thurs</option>
                                <option value = 5>Fri</option>
                            </select></th>
                            <th><select name="End">
                                <option value = 1>Mon</option>
                                <option value = 2>Tue</option>
                                <option value = 3>Wed</option>
                                <option value = 4>Thurs</option>
                                <option value = 5>Fri</option>
                            </select></th>
                            <th><input type="submit" value="Select_Section"></th>
                        </form>
                    </tr>

                    <tr>
                        <th>Day</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                    </tr>
                    

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    ResultSet rs1 = null;

                    String[] getString = new String[6];

                    getString[0] = "hello world";

                    
                    if (request.getParameter("ID") != null){

                        getString[1] = "SELECT 'MON' AS DAY, t.* FROM time_slot t WHERE NOT EXISTS ( SELECT * FROM enroll_current e1, enroll_current e2, weekly_meetings w WHERE e1.class_id = '" + request.getParameter("ID") + "' AND w.day_weekly = 'MON' AND e1.pid = e2.pid AND e2.class_id = w.class_id AND ((w.start_weekly > t.begin_time AND w.start_weekly < t.end_time) OR (w.end_weekly > t.begin_time AND w.end_weekly < t.end_time) OR (w.start_weekly = t.begin_time AND w.end_weekly = t.end_time)))";

                        getString[2] = "SELECT 'TUE' AS DAY, t.* FROM time_slot t WHERE NOT EXISTS ( SELECT * FROM enroll_current e1, enroll_current e2, weekly_meetings w WHERE e1.class_id = '" + request.getParameter("ID") + "' AND w.day_weekly = 'TUE' AND e1.pid = e2.pid AND e2.class_id = w.class_id AND ((w.start_weekly > t.begin_time AND w.start_weekly < t.end_time) OR (w.end_weekly > t.begin_time AND w.end_weekly < t.end_time) OR (w.start_weekly = t.begin_time AND w.end_weekly = t.end_time)))";

                        getString[3] = "SELECT 'WED' AS DAY, t.* FROM time_slot t WHERE NOT EXISTS ( SELECT * FROM enroll_current e1, enroll_current e2, weekly_meetings w WHERE e1.class_id = '" + request.getParameter("ID") + "' AND w.day_weekly = 'WED' AND e1.pid = e2.pid AND e2.class_id = w.class_id AND ((w.start_weekly > t.begin_time AND w.start_weekly < t.end_time) OR (w.end_weekly > t.begin_time AND w.end_weekly < t.end_time) OR (w.start_weekly = t.begin_time AND w.end_weekly = t.end_time)))";

                        getString[4] = "SELECT 'THURS' AS DAY, t.* FROM time_slot t WHERE NOT EXISTS ( SELECT * FROM enroll_current e1, enroll_current e2, weekly_meetings w WHERE e1.class_id = '" + request.getParameter("ID") + "' AND w.day_weekly = 'THURS' AND e1.pid = e2.pid AND e2.class_id = w.class_id AND ((w.start_weekly > t.begin_time AND w.start_weekly < t.end_time) OR (w.end_weekly > t.begin_time AND w.end_weekly < t.end_time) OR (w.start_weekly = t.begin_time AND w.end_weekly = t.end_time)))";

                        getString[5] = "SELECT 'FRI' AS DAY, t.* FROM time_slot t WHERE NOT EXISTS ( SELECT * FROM enroll_current e1, enroll_current e2, weekly_meetings w WHERE e1.class_id = '" + request.getParameter("ID") + "' AND w.day_weekly = 'FRI' AND e1.pid = e2.pid AND e2.class_id = w.class_id AND ((w.start_weekly > t.begin_time AND w.start_weekly < t.end_time) OR (w.end_weekly > t.begin_time AND w.end_weekly < t.end_time) OR (w.start_weekly = t.begin_time AND w.end_weekly = t.end_time)))";


                        int getStart = Integer.parseInt(request.getParameter("Begin"));
                        int getEnd = Integer.parseInt(request.getParameter("End"));


                        String sql = "(" + getString[getStart] + ")";

                        
                        for(int i = getStart+1; i <=getEnd; i++){
                            sql += "UNION ( " + getString[i] + ")";
                        }

                        String newsql = sql;
                        
                        if(getStart != getEnd){
                            newsql = "SELECT * from(" + sql + ") AS t Order by CASE t.DAY WHEN 'MON' THEN 0 WHEN 'TUE' THEN 1 WHEN 'WED' THEN 2 WHEN 'THURS' THEN 3 WHEN 'FRI' THEN 4 ELSE 5 END, begin_time";
                        }

                        rs1 = statement.executeQuery(newsql);              


                    while ( rs1.next() ) {
        
            %>

                    <tr>
                        <form action="report2b.jsp" method="post">


                            <%-- Get the COURSE_NUMBER --%>
                            <td>
                                <%= rs1.getString(1) %>
                            </td>


                            <%-- Get the COURSE_TITLE --%>
                            <td>
                                <%= rs1.getString(2) %>
                            </td>
    
    
                            <%-- Get the CONFLICT_NUMBER --%>
                            <td>
                                <%= rs1.getString(3) %>
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
                    rs1.close();
    
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
