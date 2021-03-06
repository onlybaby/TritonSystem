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
                            "INSERT INTO Prereq VALUES (?, ?)");
                        String[] arrayParams = request.getParameterValues("PREREQ_ID");
                        if (arrayParams != null){
                            for (int i = 0; i < arrayParams.length; i++){
                                pstmt.setString(1, request.getParameter("COURSE_ID"));
                                pstmt.setString(2, arrayParams[i]);
                                int rowCount = pstmt.executeUpdate();
                            }
                        }

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
                            "UPDATE prereq SET PREREQ_ID = ? WHERE COURSE_ID = ?");

                        pstmt.setString(1, request.getParameter("PREREQ_ID"));
                        pstmt.setString(2, request.getParameter("COURSE_ID"));
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
                            "DELETE FROM prereq WHERE COURSE_ID = ? AND PREREQ_ID = ?");

                        pstmt.setString(1, request.getParameter("COURSE_ID"));
                        pstmt.setString(2, request.getParameter("PREREQ_ID"));
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
                        ("SELECT * FROM prereq");
                    ResultSet rs1 = statement1.executeQuery
                        ("SELECT * FROM course");
            %>


            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course_ID</th>
                        <th>Prereq</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="prereq.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="COURSE_ID" size="10"></th>
                            <th><select name ="PREREQ_ID" multiple="multiple">
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
                        <form action="prereq.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the COURSE_ID --%>
                            <td>
                                <input value="<%= rs.getString("COURSE_ID") %>"
                                    name="COURSE_ID" size="10">
                            </td>

                            <%-- Get the PREREQ_ID --%>
                            <td>
                                <input value="<%= rs.getString("PREREQ_ID") %>"
                                    name="PREREQ_ID" size="10">
                            </td>


                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="prereq.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                value="<%= rs.getString("COURSE_ID") %>" name="COURSE_ID">
                            <input type="hidden"
                                value="<%= rs.getString("PREREQ_ID") %>" name="PREREQ_ID">
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
