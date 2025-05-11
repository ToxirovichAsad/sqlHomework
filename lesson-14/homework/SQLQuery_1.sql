

DECLARE @tableHTML NVARCHAR(MAX);


SET @tableHTML = 
N'<html>
<head>
<style>
    table {border-collapse: collapse; width: 100%;}
    th, td {border: 1px solid #dddddd; padding: 8px; text-align: left;}
    th {background-color: #f2f2f2;}
</style>
</head>
<body>
<h3>SQL Server Index Metadata Report</h3>
<table>
<tr>
    <th>Table Name</th>
    <th>Index Name</th>
    <th>Index Type</th>
    <th>Column Name</th>
    <th>Column Type</th>
</tr>' +
(
    SELECT 
        '<tr><td>' + t.name + '</td>' +
        '<td>' + i.name + '</td>' +
        '<td>' + i.type_desc + '</td>' +
        '<td>' + c.name + '</td>' +
        '<td>' + ty.name + 
        ISNULL('(' + 
            CASE 
                WHEN ty.name IN ('varchar', 'char', 'nvarchar', 'nchar') 
                     THEN 
                         CASE WHEN c.max_length = -1 THEN 'MAX' 
                              ELSE CAST(c.max_length AS VARCHAR) END
                ELSE ''
            END + ')', '') + '</td></tr>'
    FROM sys.tables t
    INNER JOIN sys.indexes i ON t.object_id = i.object_id
    LEFT JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
    LEFT JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    LEFT JOIN sys.types ty ON c.user_type_id = ty.user_type_id
    WHERE i.name IS NOT NULL
    ORDER BY t.name, i.name
    FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)')
+ 
N'</table>
</body>
</html>';

SELECT @tableHTML AS EmailHTMLPreview;





EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Gmail123', 
    @recipients = 'asadbekshukurov585@gmail.com',  
    @subject = 'SQL Server Index Metadata Report',
    @body = @tableHTML,
    @body_format = 'HTML';

