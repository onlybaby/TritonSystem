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
                            "INSERT INTO degree VALUES (?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("DEGREE_NAME"));
                        pstmt.setString(2, request.getParameter("DEGREE_TYPE"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("UNITS")));
                        pstmt.setString(4, request.getParameter("DEPT"));
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
                            "UPDATE COURSE SET COURSE_NAME = ?, MIN_UNIT = ?, " +
                            "MAX_UNIT = ?, DEPT = ?, GRADE_OPTION = ?, " +
                            "LAB_REQUIRED = ?, INSTRUCTOR_CONSENT = ?, " +
                            "CATEGORY = ? WHERE COURSE_ID = ?");

                        pstmt.setString(1, request.getParameter("COURSE_NAME"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MIN_UNIT")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("MAX_UNIT")));
                        pstmt.setString(4, request.getParameter("DEPT"));
                        pstmt.setString(5, request.getParameter("GRADE_OPTION"));
                        pstmt.setString(6, request.getParameter("LAB_REQUIRED"));
                        pstmt.setString(7, request.getParameter("INSTRUCTOR_CONSENT"));
                        pstmt.setString(8, request.getParameter("CATEGORY"));
                        pstmt.setString(9, request.getParameter("COURSE_ID"));
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
                        ("SELECT * FROM Degree");
                    ResultSet rs1 = statement1.executeQuery
                        ("SELECT * FROM Dept");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>

                        <th>Degree_name</th>
                        <th>Degree_type</th>
			            <th>units</th>
                        <th>Dept</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="DEGREE_NAME" size="10"></th>
                            <th><select name="DEGREE_TYPE">
                                <option value="BS">BS</option>
                                <option value="MS">MS</option>
                                <option value="BS/MS">BS/MS</option>
                                <option value="PHD">PHD</option>
                            </select></th>
                            <th><input value="" name="UNITS" size="15"></th>
                            <th><select name="DEPT">
                                <%  while(rs1.next()){ %>
                                <option><%= rs1.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the DEGREE_NAME --%>
                            <td>
                                <input value="<%= rs.getString("DEGREE_NAME") %>" 
                                    name="DEGREE_NAME" size="10">
                            </td>
    
                            <%-- Get the DEGREE_TYPE --%>
                            <td>
                                <input value="<%= rs.getString("DEGREE_TYPE") %>" 
                                    name="DEGREE_TYPE" size="10">
                            </td>
    
                            <%-- Get the UNITS --%>
                            <td>
                                <input value="<%= rs.getInt("UNITS") %>"
                                    name="UNITS" size="15">
                            </td>
    

                            <%-- Get the DEPT --%>
                            <td>
                                <input value="<%= rs.getString("DEPT") %>" 
                                    name="DEPT" size="15">
                            </td>
    

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="degree.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("degree_name") %>" name="degree_name">
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
