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
                            "INSERT INTO concentration_degree VALUES (?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("con_name"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MIN_UNIT")));
                        pstmt.setString(3, request.getParameter("DEPT"));
                        pstmt.setString(4, request.getParameter("DEGREE_TYPE"));
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
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE concentration_degree SET  MIN_UNIT= ? WHERE con_name = ? AND DEPT = ? AND DEGREE_TYPE = ?");


                            pstmt.setInt(1, Integer.parseInt(request.getParameter("MIN_UNIT")));
                            pstmt.setString(2, request.getParameter("con_name"));
                            pstmt.setString(3, request.getParameter("DEPT"));
                            pstmt.setString(4, request.getParameter("DEGREE_TYPE"));
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
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM concentration_degree WHERE con_name = ? AND DEPT = ? AND DEGREE_TYPE");

                            pstmt.setString(1, request.getParameter("con_name"));
                            pstmt.setString(2, request.getParameter("DEPT"));
                            pstmt.setString(3, request.getParameter("DEGREE_TYPE"));
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
                    Statement statement2 = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM concentration_degree");
                    ResultSet rs1 = statement1.executeQuery
                        ("SELECT * FROM dept");
                    ResultSet rs2 = statement2.executeQuery
                        ("SELECT * FROM Concentration");
            %>


            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>con_name</th>
                        <th>MIN_UNIT</th>
			            <th>DEPT</th>
                        <th>DEGREE_TYPE</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="condegree.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><select name="con_name">
                                <%  while(rs2.next()){ %>
                                <option><%= rs2.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><input value="" name="MIN_UNIT" size="10"></th>
                            <th><select name="DEPT">
                                <%  while(rs1.next()){ %>
                                <option><%= rs1.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><select name="DEGREE_TYPE">
                                <option value="BS">BS</option>
                                <option value="MS">MS</option>
                                <option value="BS/MS">BS/MS</option>
                                <option value="PHD">PHD</option>
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
                        <form action="condegree.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the con_name --%>
                            <td>
                                <input value="<%= rs.getString("con_name") %>"
                                    name="con_name" size="10">
                            </td>

                            <%-- Get the MIN_UNIT --%>
                            <td>
                                <input value="<%= rs.getInt("MIN_UNIT") %>"
                                    name="MIN_UNIT" size="10">
                            </td>


                            <%-- Get the DEPT --%>
                            <td>
                                <input value="<%= rs.getString("DEPT") %>"
                                    name="DEPT" size="15">
                            </td>

			                <%-- Get the DEGREE_TYPE --%>
                            <td>
                                <input value="<%= rs.getString("DEGREE_TYPE") %>"
                                    name="DEGREE_TYPE" size="15">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="condegree.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getString("con_name") %>" name="con_name">
                            <input type="hidden"
                                value="<%= rs.getString("DEPT") %>" name="DEPT">
                            <input type="hidden"
                                value="<%= rs.getString("DEGREE_TYPE") %>" name="DEGREE_TYPE">
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
