using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class ParameterBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(Parameter obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addParameter", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@ParaCode1", obj.ParaCode1);
            sqlCmd.Parameters.AddWithValue("@ParaCode2", obj.ParaCode2);
            sqlCmd.Parameters.AddWithValue("@ParaCode3", obj.ParaCode3);
            sqlCmd.Parameters.AddWithValue("@Desc1", obj.Desc1);
            sqlCmd.Parameters.AddWithValue("@Desc2", obj.Desc2);
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

    public int Update(Parameter obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("updParameter", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@ParaCode1", obj.ParaCode1);
            sqlCmd.Parameters.AddWithValue("@ParaCode2", obj.ParaCode2);
            sqlCmd.Parameters.AddWithValue("@ParaCode3", obj.ParaCode3);
            sqlCmd.Parameters.AddWithValue("@Desc1", obj.Desc1);
            sqlCmd.Parameters.AddWithValue("@Desc2", obj.Desc2);
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

    public int Delete(Parameter obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("delParameter", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@ParaCode1", obj.ParaCode1);
            sqlCmd.Parameters.AddWithValue("@ParaCode2", obj.ParaCode2);
            sqlCmd.Parameters.AddWithValue("@ParaCode3", obj.ParaCode3);
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

    public List<Parameter> Retrieve()
    {
        List<Parameter> result = GetData(false, "", "");
        return result;
    }

    public List<Parameter> SelectParaCode1()
    {
        //Returns all distinct paracode 1
        List<Parameter> result = GetData(true, "ParaCode1", "");
        return result;
    }

    public List<Parameter> SelectParaCode2(string p1)
    {
        //Returns all distinct paracode 2 based on p1
        List<Parameter> result = GetData(true, "ParaCode2", p1);
        return result;
    }

    public List<Parameter> SelectByParaCode1(string p1)
    {
        //Returns all paracode where ParaCode 1 = p1
        List<Parameter> result = Retrieve().Where(obj => obj.ParaCode1.Equals(p1)).ToList();
        return result;
    }

    public List<Parameter> SelectByParaCode1And2(string p1, string p2)
    {
        //Returns all distinct paracode 3 based on p1 and p2
        //Returns all paracode where ParaCode 1 = p1 and ParaCode 2 = p2
        List<Parameter> result = Retrieve().Where(obj => obj.ParaCode1.Equals(p1) && obj.ParaCode2.Equals(p2)).ToList();
        return result;
    }

    public Parameter SelectByAllParaCode(string p1, string p2, string p3)
    {
        //Returns a paracode where ParaCode 1 = p1 and ParaCode 2 = p2 and ParaCode 3 = p3
        Parameter result = Retrieve().Where(obj => obj.ParaCode1.Equals(p1) && obj.ParaCode2.Equals(p2) && obj.ParaCode3.Equals(p3)).FirstOrDefault();
        return result;
    }

    protected List<Parameter> GetData(bool isDistinct, string paracode, string queryparam)
    {
        List<Parameter> result = new List<Parameter>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = $"SELECT {(isDistinct ? "DISTINCT " + paracode : "*")} FROM Parameter {(paracode == "ParaCode2"? "WHERE ParaCode1 = '" + queryparam + "'" : "")}";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                Parameter obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected Parameter ToObj(DataRow row)
    {
        Parameter obj = null;
        try
        {
            string p1 = row.Table.Columns.Contains("ParaCode1") ? CommonBL.StringMapper(row["ParaCode1"]) : "";
            string p2 = row.Table.Columns.Contains("ParaCode2") ? CommonBL.StringMapper(row["ParaCode2"]) : "";
            string p3 = row.Table.Columns.Contains("ParaCode3") ? CommonBL.StringMapper(row["ParaCode3"]) : "";
            string d1 = row.Table.Columns.Contains("Desc1") ? CommonBL.StringMapper(row["Desc1"]) : "";
            string d2 = row.Table.Columns.Contains("Desc2") ? CommonBL.StringMapper(row["Desc2"]) : "";
            string cBy = row.Table.Columns.Contains("CreateBy") ? CommonBL.StringMapper(row["CreateBy"]) : "";
            DateTime cDate = row.Table.Columns.Contains("CreateDate") ? CommonBL.DateTimeMapper(row["CreateDate"].ToString()) : new DateTime();
            string aBy = row.Table.Columns.Contains("AmendBy") ? CommonBL.StringMapper(row["AmendBy"]) : "";
            DateTime aDate = row.Table.Columns.Contains("AmendDate") ? CommonBL.DateTimeMapper(row["AmendDate"].ToString()) : new DateTime();

            obj = new Parameter(p1, p2, p3, d1, d2, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }

    public string Validate(Parameter ValObj, string reqtype)
    {
        StringBuilder errorMsg = new StringBuilder();
        if (string.IsNullOrEmpty(ValObj.ParaCode1))
        {
            errorMsg.Append("ParaCode 1 is mandatory.<br/>");
        }
        
        if (string.IsNullOrEmpty(ValObj.Desc1))
        {
            errorMsg.Append("Description 1 is mandatory.<br/>");
        }

        Parameter ParamObj = SelectByAllParaCode(ValObj.ParaCode1, ValObj.ParaCode2, ValObj.ParaCode3);
        if (ParamObj != null)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                errorMsg.Append("Parameter already exists. Please try another paracode combination.<br/>");
            }
        }

        return errorMsg.ToString();
    }
}
