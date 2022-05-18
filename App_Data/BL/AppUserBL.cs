using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class AppUserBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(AppUser obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addAppUser", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@LoginID", obj.LoginID);
            sqlCmd.Parameters.AddWithValue("@Email", obj.Email);
            sqlCmd.Parameters.AddWithValue("@PasswordHash", obj.PasswordHash);
            sqlCmd.Parameters.AddWithValue("@PasswordSalt", obj.PasswordSalt);
            sqlCmd.Parameters.AddWithValue("@IV", obj.IV);
            sqlCmd.Parameters.AddWithValue("@Key", obj.Key);
            sqlCmd.Parameters.AddWithValue("@UsrName", obj.UsrName);
            sqlCmd.Parameters.AddWithValue("@UsrShtName", obj.UsrShtName);
            sqlCmd.Parameters.AddWithValue("@UsrType", obj.UsrType);
            sqlCmd.Parameters.AddWithValue("@UsrRole", obj.UsrRole);
            sqlCmd.Parameters.AddWithValue("@UsrStatus", obj.UsrStatus);
            sqlCmd.Parameters.AddWithValue("@LockStatus", obj.LockStatus);
            sqlCmd.Parameters.AddWithValue("@AccessRgt", obj.AccessRgt);
            sqlCmd.Parameters.AddWithValue("@AccessRgtGrp", obj.AccessRgtGrp);
            sqlCmd.Parameters.AddWithValue("@CreateBy", obj.CreateBy);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value;
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "Create", e.Message);
        }
        finally
        {
            sqlConn.Close();
        }

        return result;
    }

    public int Update(AppUser obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("updAppUser", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@LoginID", obj.LoginID);
            sqlCmd.Parameters.AddWithValue("@Email", obj.Email);
            sqlCmd.Parameters.AddWithValue("@PasswordHash", obj.PasswordHash);
            sqlCmd.Parameters.AddWithValue("@PasswordSalt", obj.PasswordSalt);
            sqlCmd.Parameters.AddWithValue("@IV", obj.IV);
            sqlCmd.Parameters.AddWithValue("@Key", obj.Key);
            sqlCmd.Parameters.AddWithValue("@UsrName", obj.UsrName);
            sqlCmd.Parameters.AddWithValue("@UsrShtName", obj.UsrShtName);
            sqlCmd.Parameters.AddWithValue("@UsrType", obj.UsrType);
            sqlCmd.Parameters.AddWithValue("@UsrRole", obj.UsrRole);
            sqlCmd.Parameters.AddWithValue("@UsrStatus", obj.UsrStatus);
            sqlCmd.Parameters.AddWithValue("@LockStatus", obj.LockStatus);
            if (obj.LockUntil.Equals(new DateTime()))
                sqlCmd.Parameters.AddWithValue("@LockUntil", DBNull.Value);
            else
                sqlCmd.Parameters.AddWithValue("@LockUntil", obj.LockUntil);
            if (obj.LastLogin.Equals(new DateTime()))
                sqlCmd.Parameters.AddWithValue("@LastLogin", DBNull.Value);
            else
                sqlCmd.Parameters.AddWithValue("@LastLogin", obj.LastLogin);
            sqlCmd.Parameters.AddWithValue("@LastPwdSet", obj.LastPwdSet);
            sqlCmd.Parameters.AddWithValue("@AccessRgt", obj.AccessRgt);
            sqlCmd.Parameters.AddWithValue("@AccessRgtGrp", obj.AccessRgtGrp);
            sqlCmd.Parameters.AddWithValue("@AmendBy", obj.AmendBy);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value;
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "Update", e.Message);
        }
        finally
        {
            sqlConn.Close();
        }

        return result;
    }

    public int Delete(AppUser obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("delAppUser", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@LoginID", obj.LoginID);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value;
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "Delete", e.Message);
        }
        finally
        {
            sqlConn.Close();
        }

        return result;
    }

    public List<AppUser> Retrieve()
    {
        List<AppUser> result = GetData();
        return result;
    }

    public AppUser SelectByLoginID(string loginid)
    {
        AppUser result = Retrieve().Where(obj => obj.LoginID.Equals(loginid)).FirstOrDefault();
        return result;
    }

    protected List<AppUser> GetData()
    {
        List<AppUser> result = new List<AppUser>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM AppUser";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                AppUser obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected AppUser ToObj(DataRow row)
    {
        AppUser obj = null;
        try
        {
            string loginid = CommonBL.StringMapper(row["LoginID"]);
            string email = CommonBL.StringMapper(row["Email"]);
            string pwdhash = CommonBL.StringMapper(row["PasswordHash"]);
            string pwdsalt = CommonBL.StringMapper(row["PasswordSalt"]);
            string iv = CommonBL.StringMapper(row["IV"]);
            string key = CommonBL.StringMapper(row["Key"]);
            string usrname = CommonBL.StringMapper(row["UsrName"]);
            string usrshtname = CommonBL.StringMapper(row["UsrShtName"]);
            string usrtype = CommonBL.StringMapper(row["UsrType"]);
            string usrrole = CommonBL.StringMapper(row["UsrRole"]);
            string usrstatus = CommonBL.StringMapper(row["UsrStatus"]);
            string lockstatus = CommonBL.StringMapper(row["LockStatus"]);
            DateTime lockuntil = CommonBL.DateTimeMapper(row["LockUntil"].ToString());
            string accessrgt = CommonBL.StringMapper(row["AccessRgt"]);
            string accessrgtgrp = CommonBL.StringMapper(row["AccessRgtGrp"]);
            DateTime lastlogin = CommonBL.DateTimeMapper(row["LastLogin"].ToString());
            DateTime lastpwdset = CommonBL.DateTimeMapper(row["LastPwdSet"].ToString());
            string cBy = CommonBL.StringMapper(row["CreateBy"]);
            DateTime cDate = CommonBL.DateTimeMapper(row["CreateDate"].ToString());
            string aBy = CommonBL.StringMapper(row["AmendBy"]);
            DateTime aDate = CommonBL.DateTimeMapper(row["AmendDate"].ToString());

            obj = new AppUser(loginid, email, pwdhash, pwdsalt, iv, key, usrname, usrshtname, usrtype, usrrole, usrstatus, lockstatus, lockuntil, accessrgt, accessrgtgrp, lastlogin, lastpwdset, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }

    public string Validate(AppUser ValObj, string reqtype)
    {
        StringBuilder errorMsg = new StringBuilder();
        if (string.IsNullOrEmpty(ValObj.LoginID) || string.IsNullOrEmpty(ValObj.UsrName) || string.IsNullOrEmpty(ValObj.UsrShtName) || (ValObj.UsrType.Equals("I") && string.IsNullOrEmpty(ValObj.Email)))
        {
            errorMsg.Append("Please complete all fields.<br/>");
        }

        AppUser UserObj1 = SelectByLoginID(ValObj.LoginID);
        if (UserObj1 != null)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                errorMsg.Append("LoginID already taken. Please try another one.<br/>");
            }
        }

        AppUser UserObj2 = Retrieve().Where(obj => obj.UsrShtName.Equals(ValObj.UsrShtName)).FirstOrDefault();
        if (UserObj2 != null)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                errorMsg.Append("User Short Name already taken. Please try another one.<br/>");
            }
            else if (reqtype.Equals(CommonBL.ConstantType_Update))
            {
                if (UserObj2.LoginID != UserObj1.LoginID)
                {
                    errorMsg.Append("User Short Name already taken. Please try another one.<br/>");
                }
            }
        }

        return errorMsg.ToString();
    }

    public int ChangePassword(AppUser obj)
    {
        //TODO
        throw new NotImplementedException();
    }

    public int ResetPassword(AppUser obj)
    {
        //TODO
        throw new NotImplementedException();
    }
}
