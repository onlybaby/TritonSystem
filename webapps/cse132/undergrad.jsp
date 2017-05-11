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
                            "INSERT INTO Undergrad VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("PID")));
                        pstmt.setString(2, request.getParameter("COLLEGE"));
                       pstmt.setString(3, request.getParameter("MAJOR"));
                       pstmt.setString(4, request.getParameter("MINOR"));
                        pstmt.setString(5, request.getParameter("MAJOR_TYPE"));
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
                            "UPDATE Undergrad SET COLLEGE = ?, MAJOR = ?, " +
                            "MINOR = ?, MAJOR_TYPE = ? WHERE PID = ?");

                            pstmt.setString(1, request.getParameter("COLLEGE"));
                           pstmt.setString(2, request.getParameter("MAJOR"));
                           pstmt.setInt(
                               3, Integer.parseInt(request.getParameter("MINOR")));
                            pstmt.setString(4, request.getParameter("MAJOR_TYPE"));
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
                            "DELETE FROM Undergrad WHERE PID = ?");

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
                    //Statement statement1 = conn.createStatement();
                    //Statement statement2 = conn.createStatement();
                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Undergrad");
                        // ResultSet rs1 = statement1.executeQuery
                        //     ("SELECT * FROM Dept");
                        // ResultSet rs2 = statement2.executeQuery
                        //     ("SELECT * FROM Faculty");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>PID</th>
                        <th>COLLEGE</th>
                        <th>MAJOR</th>
                        <th>MINOR</th>
                        <th>MAJOR_TYPE</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="undergrad.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="PID" size="10"></th>
                            <th><select name="COLLEGE">
                                <option value="SIX">SIX</option>
                                <option value="REVELLE">REVELLE</option>
                                <option value="ERC">ERC</option>
                                <option value="JOIN MUIR">JOIN MUIR</option>
                                <option value="WARREN">WARREN</option>
                                <option value="MARSHALL">MARSHALL</option>
                                </select>
                            </th>
                            <th><input value="" name="MAJOR" size="20"></th>
                            <th><input value="" name="MINOR" size="20"></th>
                            <th><select name="MAJOR_TYPE">
                                <option value="BS">BS</option>
                                <option value="MS">MS</option>
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
                        <form action="undegrad.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the PID, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("PID") %>"
                                    name="PID" size="10">
                            </td>

                            <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getString("COLLEGE") %>"
                                    name="COLLEGE" size="20">
                            </td>

                            <%-- Get the MAJOR --%>
                            <td>
                                <input value="<%= rs.getString("MAJOR") %>"
                                    name="MAJOR" size="20">
                            </td>

                            <%-- Get the MINOR --%>
                            <td>
                                <input value="<%= rs.getString("MINOR") %>"
                                    name="MINOR" size="20">
                            </td>

                            <%-- Get the MAJOR_TYPE --%>
                            <td>
                                <input value="<%= rs.getString("MAJOR_TYPE") %>"
                                    name="MAJOR_TYPE" size="20">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="undegrad.jsp" method="get">
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
                    // rs1.close();
                    // rs2.close();

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
