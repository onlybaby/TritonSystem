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
                            "INSERT INTO faculty VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("faculty_name"));
                        pstmt.setString(2, request.getParameter("title"));
                        pstmt.setString(3, request.getParameter("dept"));

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
                            "UPDATE faculty SET title = ?, dept = ? WHERE faculty_name = ?");


                        pstmt.setString(1, request.getParameter("title"));
                        pstmt.setString(2, request.getParameter("dept"));
                        pstmt.setString(3, request.getParameter("faculty_name"));
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
                            "DELETE FROM faculty WHERE faculty_name = ?");

                        pstmt.setString(1, request.getParameter("faculty_name"));
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
                        ("SELECT * FROM faculty");
                    ResultSet rs1 = statement1.executeQuery
                        ("SELECT * FROM dept");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>faculty_name</th>
                        <th>title</th>
                        <th>dept</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="faculty_name" size="10"></th>
                            <th><input value="" name="title" size="10"></th>
                            <th><select name="dept">
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
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the faculty_name --%>
                            <td>
                                <input value="<%= rs.getString("faculty_name") %>" 
                                    name="faculty_name" size="10">
                            </td>


                            <%-- Get the title --%>
                            <td>
                                <input value="<%= rs.getString("title") %>" 
                                    name="title" size="10">
                            </td>

                            <%-- Get the dept --%>
                            <td>
                                <input value="<%= rs.getString("dept") %>" 
                                    name="dept" size="10">
                            </td>
    
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("faculty_name") %>" name="faculty_name">
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
