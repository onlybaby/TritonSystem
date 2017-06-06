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
                        <form action="report3.jsp" method="get">
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
                        <th>Professor</th>
                        <th>Grade</th>
                        <th>Count Of Grade</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    String[] values = request.getParameter("TAUGHT_QUARTER").split(",");
                    String[] values1 = request.getParameter("COURSE_ID").split(",");
                    ResultSet rs2 = statement2.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                         "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                         "WHERE c.QUARTER = '" + values[0] + "' AND c.YEAR = "+Integer.parseInt(values[1]) +
                         " AND c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'A' OR e.GRADE_RECEIVED = 'A+' OR e.GRADE_RECEIVED = 'A-')");

                         ResultSet rs7 = statement7.executeQuery
                             ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                              "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                              "WHERE c.QUARTER = '" + values[0] + "' AND c.YEAR = "+Integer.parseInt(values[1]) +
                              " AND c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'B' OR e.GRADE_RECEIVED = 'B+' OR e.GRADE_RECEIVED = 'B-')");
                    ResultSet rs8 = statement8.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                         "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                         "WHERE c.QUARTER = '" + values[0] + "' AND c.YEAR = "+Integer.parseInt(values[1]) +
                         " AND c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'C' OR e.GRADE_RECEIVED = 'C+' OR e.GRADE_RECEIVED = 'C-')");
                    ResultSet rs9 = statement9.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                        "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                        "WHERE e.GRADE_RECEIVED = 'D' AND c.QUARTER = '" + values[0] + "' AND c.YEAR = "+Integer.parseInt(values[1]) +
                        " AND c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "'");

                  ResultSet rs3 = statement3.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                         "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                         "WHERE c.QUARTER = '" + values[0] + "' AND c.YEAR = "+Integer.parseInt(values[1]) +
                         " AND c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND e.GRADE_RECEIVED != 'A' AND e.GRADE_RECEIVED != 'A+' AND e.GRADE_RECEIVED != 'A-' AND e.GRADE_RECEIVED != 'B' AND e.GRADE_RECEIVED != 'B+' AND e.GRADE_RECEIVED != 'B-' AND e.GRADE_RECEIVED != 'C' AND e.GRADE_RECEIVED != 'C+' AND e.GRADE_RECEIVED != 'C-' AND e.GRADE_RECEIVED != 'D'");

                    // rs.close();
                    //
                    // rs = statement.executeQuery
                    //     ("SELECT * FROM enroll_current");
                    while ( rs2.next() ) {

            %>

                    <tr>
                        <form action="report3.jsp" method="post">


                            <%-- Get the Professor --%>
                            <td>
                              <%= values1[1] %>
                            </td>
                                <td>A</td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs2.getString(1) %>
                            </td>

                        </form>
                    </tr>
            <%
                    }
                while (rs7.next()) {
            %>
            <tr>
                <form action="report3.jsp" method="post">


                    <%-- Get the Professor --%>
                    <td>
                      <%= values1[1] %>
                    </td>
                        <td>B</td>

                    <%-- Get the COUNT --%>
                    <td>
                      <%= rs7.getString(1) %>
                    </td>

                </form>
            </tr>
    <%
            }
        while (rs8.next()) {
    %>

    <tr>
        <form action="report3.jsp" method="post">


            <%-- Get the Professor --%>
            <td>
              <%= values1[1] %>
            </td>
                <td>C</td>

            <%-- Get the COUNT --%>
            <td>
              <%= rs8.getString(1) %>
            </td>

        </form>
    </tr>
        <%
                    }
                      while (rs9.next()) {
        %>

        <tr>
            <form action="report3.jsp" method="post">
            <td>
              <%= values1[1] %>
            </td>
            <td>D</td>
            <td>
              <%= rs9.getString(1) %>
            </td>

            </form>
        </tr>
        <%
          }
        %>

            <%  while ( rs3.next() ) { %>
            <tr>
                <form action="report3.jsp" method="post">
                <td>
                  <%= values1[1] %>
                </td>
                    <td>Other</td>
                    <%-- Get the Professor --%>
                    <td>
                      <%= rs3.getString(1) %>
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
        <th>Professor</th>
        <th>Grade</th>
        <th>Count Of Grade</th>
    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    ResultSet rs4 = statement4.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                         "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                         "WHERE c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'A' OR e.GRADE_RECEIVED = 'A+' OR e.GRADE_RECEIVED = 'A-') ");
                    ResultSet rs10 = statement10.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                        "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                        "WHERE c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'B' OR e.GRADE_RECEIVED = 'B+' OR e.GRADE_RECEIVED = 'B-') ");

                    ResultSet rs11 = statement11.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                        "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                        "WHERE c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'C' OR e.GRADE_RECEIVED = 'C+' OR e.GRADE_RECEIVED = 'C-') ");

                   ResultSet rs12 = statement12.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                        "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                        "WHERE c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND e.GRADE_RECEIVED = 'D'");
                  ResultSet rs5 = statement5.executeQuery
                        ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                         "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                         "WHERE c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND e.GRADE_RECEIVED != 'A' AND e.GRADE_RECEIVED != 'B' AND e.GRADE_RECEIVED != 'C' AND e.GRADE_RECEIVED != 'D' AND e.GRADE_RECEIVED != 'A+' AND e.GRADE_RECEIVED != 'A-' AND e.GRADE_RECEIVED != 'B+' AND e.GRADE_RECEIVED != 'B-' AND e.GRADE_RECEIVED != 'C+' AND e.GRADE_RECEIVED != 'C-'");

                    // rs.close();
                    //
                    // rs = statement.executeQuery
                    //     ("SELECT * FROM enroll_current");
                    while ( rs4.next() ) {

            %>

                    <tr>
                        <form action="report3.jsp" method="post">

                            <%-- Get the Professor --%>
                            <td>
                              <%= values1[1] %>
                            </td>
                                <td>A</td>

                            <%-- Get the COUNT --%>
                            <td>
                              <%= rs4.getString(1) %>
                            </td>

                        </form>
                    </tr>
            <%
                    }
                    while (rs10.next()) {
                %>
                <tr>
                    <form action="report3.jsp" method="post">


                        <%-- Get the Professor --%>
                        <td>
                          <%= values1[1] %>
                        </td>
                            <td>B</td>

                        <%-- Get the COUNT --%>
                        <td>
                          <%= rs10.getString(1) %>
                        </td>

                    </form>
                </tr>
        <%
                }
            while (rs11.next()) {
        %>

        <tr>
            <form action="report3.jsp" method="post">


                <%-- Get the Professor --%>
                <td>
                  <%= values1[1] %>
                </td>
                    <td>C</td>

                <%-- Get the COUNT --%>
                <td>
                  <%= rs11.getString(1) %>
                </td>

            </form>
        </tr>
            <%
                        }
                          while ( rs12.next()) {
            %>

            <tr>
                <form action="report3.jsp" method="post">
                <td>
                  <%= values1[1] %>
                </td>
                <td>D</td>
                <td>
                  <%= rs12.getString(1) %>
                </td>

                </form>
            </tr>
            <%
              }
            %>

            <%  while ( rs5.next() ) { %>
            <tr>
                <form action="report3.jsp" method="post">
                <td>
                  <%= values1[1] %>
                </td>
                    <td>Other</td>
                    <%-- Get the Professor --%>
                    <td>
                      <%= rs5.getString(1) %>
                    </td>

                </form>
            </tr>
    <%
            }
    %>

    <tr>
        <td>Grade Point Average  Over The Years</td>
    </tr>
    <tr>
        <th>Professor</th>
        <th>Grade Point Average</th>
    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    ResultSet rs6 = statement6.executeQuery
                        ("SELECT SUM(g.NUMBER_GRADE)/ COUNT(e.GRADE_RECEIVED) FROM class c " +
                         "INNER JOIN enrolled_list e ON e.CLASS_ID = c.CLASS_ID " +
                         "INNER JOIN GRADE_CONVERSION g ON e.GRADE_RECEIVED = g.LETTER_GRADE " +
                         "WHERE c.INSTRUCTOR = '" + values1[1] + "' AND c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'A' OR e.GRADE_RECEIVED = 'B' OR e.GRADE_RECEIVED = 'C' OR e.GRADE_RECEIVED = 'D' OR e.GRADE_RECEIVED = 'A+' OR e.GRADE_RECEIVED = 'A-' OR e.GRADE_RECEIVED = 'B+' OR e.GRADE_RECEIVED = 'B-' OR e.GRADE_RECEIVED = 'C+' OR e.GRADE_RECEIVED = 'C-')");

                    // rs.close();
                    //
                    // rs = statement.executeQuery
                    //     ("SELECT * FROM enroll_current");
                    while ( rs6.next() ) {

            %>

                    <tr>
                        <form action="report3.jsp" method="post">


                            <%-- Get the Professor --%>
                            <td>
                              <%= values1[1] %>
                            </td>

                            <%-- Get the GRADE_POINT_AVG --%>
                            <td>
                              <%= rs6.getString(1) %>
                            </td>

                        </form>
                    </tr>
            <%
                    }
            %>

            <tr>
                <td>Grade Distribution Over The Years By Any Professor</td>
            </tr>
            <tr>
                <th>Grade</th>
                <th>Count Of Grade</th>
            </tr>

                    <%-- -------- Iteration Code -------- --%>
                    <%
                            // Iterate over the ResultSet
                            ResultSet rs13 = statement13.executeQuery
                                ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                                 "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                                 "WHERE c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'A' OR e.GRADE_RECEIVED = 'A+' OR e.GRADE_RECEIVED = 'A-') ");
                            ResultSet rs14 = statement14.executeQuery
                                ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                                "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                                "WHERE c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'B' OR e.GRADE_RECEIVED = 'B+' OR e.GRADE_RECEIVED = 'B-') ");

                            ResultSet rs15 = statement15.executeQuery
                                ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                                "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                                "WHERE c.COURSE_ID = '" + values1[0] + "' AND (e.GRADE_RECEIVED = 'C' OR e.GRADE_RECEIVED = 'C+' OR e.GRADE_RECEIVED = 'C-') ");

                           ResultSet rs16 = statement16.executeQuery
                                ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                                "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                                "WHERE c.COURSE_ID = '" + values1[0] + "' AND e.GRADE_RECEIVED = 'D'");
                          ResultSet rs17 = statement17.executeQuery
                                ("SELECT COUNT(e.GRADE_RECEIVED) FROM enrolled_list e " +
                                 "INNER JOIN class c ON e.CLASS_ID = c.CLASS_ID " +
                                 "WHERE c.COURSE_ID = '" + values1[0] + "' AND e.GRADE_RECEIVED != 'A' AND e.GRADE_RECEIVED != 'B' AND e.GRADE_RECEIVED != 'C' AND e.GRADE_RECEIVED != 'D' AND e.GRADE_RECEIVED != 'A+' AND e.GRADE_RECEIVED != 'A-' AND e.GRADE_RECEIVED != 'B+' AND e.GRADE_RECEIVED != 'B-' AND e.GRADE_RECEIVED != 'C+' AND e.GRADE_RECEIVED != 'C-'");

                            // rs.close();
                            //
                            // rs = statement.executeQuery
                            //     ("SELECT * FROM enroll_current");
                            while ( rs13.next() ) {

                    %>

                            <tr>
                                <form action="report3.jsp" method="post">

                                    <%-- Get the Professor --%>
                                        <td>A</td>

                                    <%-- Get the COUNT --%>
                                    <td>
                                      <%= rs13.getString(1) %>
                                    </td>

                                </form>
                            </tr>
                    <%
                            }
                            while (rs14.next()) {
                        %>
                        <tr>
                            <form action="report3.jsp" method="post">

                                    <td>B</td>

                                <%-- Get the COUNT --%>
                                <td>
                                  <%= rs14.getString(1) %>
                                </td>

                            </form>
                        </tr>
                <%
                        }
                    while (rs15.next()) {
                %>

                <tr>
                    <form action="report3.jsp" method="post">

                            <td>C</td>

                        <%-- Get the COUNT --%>
                        <td>
                          <%= rs15.getString(1) %>
                        </td>

                    </form>
                </tr>
                    <%
                                }
                                  while ( rs16.next()) {
                    %>

                    <tr>
                        <form action="report3.jsp" method="post">
                        <td>D</td>
                        <td>
                          <%= rs16.getString(1) %>
                        </td>

                        </form>
                    </tr>
                    <%
                      }
                    %>

                    <%  while ( rs17.next() ) { %>
                    <tr>
                        <form action="report3.jsp" method="post">
                            <td>Other</td>
                            <%-- Get the Professor --%>
                            <td>
                              <%= rs17.getString(1) %>
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
                    rs4.close();
                    rs5.close();
                    rs6.close();

                    // Close the Statement
                    statement.close();
                    statement1.close();
                    statement2.close();
                    statement3.close();
                    statement4.close();
                    statement5.close();
                    statement6.close();
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
