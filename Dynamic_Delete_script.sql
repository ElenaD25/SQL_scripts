ALTER proc [crc].[DeleteRecordById] @schema nvarchar(100), @table nvarchar(200), @column_n nvarchar(150), @value nvarchar(150)
as 
	begin
        begin try
            declare @params nvarchar(3000) = N'@value_p nvarchar(1000)',
                    @ErrorMsg nvarchar(4000),@ErrorSeverity int, @ErrorState int,
                    @sql nvarchar(max) = N'delete from ' + quotename(trim(@schema)) + '.' 
                                        + quotename(trim(@table)) +' where ' + trim(@column_n) + '= trim(@value_p)'
            
        
            execute sp_executesql @sql, @params, @value_p = @value;
	    end try

	begin catch
		      select @ErrorMsg = ERROR_MESSAGE(),
				     @ErrorSeverity = ERROR_SEVERITY(),
				     @ErrorState =ERROR_STATE()

          raiserror(@ErrorMsg,@ErrorSeverity,@ErrorState)
	end catch
	end
