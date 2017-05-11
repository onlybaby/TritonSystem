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
                            "INSERT INTO Grad VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setString(2, request.getParameter("DEPT"));
                       pstmt.setString(3, request.getParameter("PROGRAM"));
                       pstmt.setInt(
                           4, Integer.parseInt(request.getParameter("NUM_OF_COMMITTEE")));
                        pstmt.setString(5, request.getParameter("ADVISOR"));
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
                            "UPDATE Grad SET DEPT = ?, PROGRAM = ?, " +
                            "NUM_OF_COMMITTEE = ?, ADVISOR = ? WHERE PID = ?");

                            pstmt.setString(1, request.getParameter("DEPT"));
                           pstmt.setString(2, request.getParameter("PROGRAM"));
                           pstmt.setInt(
                               3, Integer.parseInt(request.getParameter("NUM_OF_COMMITTEE")));
                            pstmt.setString(4, request.getParameter("ADVISOR"));
                        pstmt.setInt(
                            5, Integer.parseInt(request.getParameter("PID")));
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
                            "DELETE FROM Grad WHERE PID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PID")));
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
                        ("SELECT * FROM Grad");
                        ResultSet rs1 = statement1.executeQuery
                            ("SELECT * FROM Dept");
                        ResultSet rs2 = statement2.executeQuery
                            ("SELECT * FROM Faculty");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>PID</th>
                        <th>DEPT</th>
                        <th>PROGRAM</th>
                        <th>NUM_OF_COMMITTEE</th>
                        <th>ADVISOR</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="grad.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="PID" size="10"></th>
                            <th><select name="DEPT">
                                <%  while(rs1.next()){ %>
                                <option><%= rs1.getString(1)%></option>
                                <% } %>
                            </select></th>
                            <th><select name="PROGRAM">
                                <option value="MS">MS</option>
                                <option value="PHD CANDIDATE">PHD CANDIDATE</option>
                                <option value="PHD PRE-CANDIDACY">PHD PRE-CANDIDACY</option>
                                </select>
                            </th>
                            <th><input value="" name="NUM_OF_COMMITTEE" size="10"></th>
                            <th><select name="ADVISOR">
                                <%  while(rs2.next()){ %>
                                <option><%= rs2.getString(1)%></option>
                                <% } %>
                                <option value="NONE">NONE</option>
                                </select>
                            </th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

            %>

                    <tr>
                        <form action="grad.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the PID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("PID") %>"
                                    name="PID" size="10">
                            </td>

                            <%-- Get the DEPT --%>
                            <td>
                                <input value="<%= rs.getString("DEPT") %>"
                                    name="DEPT" size="20">
                            </td>

                            <%-- Get the PROGRAM --%>
                            <td>
                                <input value="<%= rs.getString("PROGRAM") %>"
                                    name="PROGRAM" size="20">
                            </td>

                            <%-- Get the NUM_OF_COMMITTEE --%>
                            <td>
                                <input value="<%= rs.getString("NUM_OF_COMMITTEE") %>"
                                    name="NUM_OF_COMMITTEE" size="10">
                            </td>

                            <%-- Get the ADVISOR --%>
                            <td>
                                <input value="<%= rs.getString("ADVISOR") %>"
                                    name="ADVISOR" size="20">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="grad.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getInt("PID") %>" name="PID">
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
                    rs2.close();

                    // Close the Statement
                    statement.close();
                    statement1.close();
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
