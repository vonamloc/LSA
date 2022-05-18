using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class QuestionnaireBL
{
    readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;

    public int Create(Questionnaire obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("addQuestionnaire", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@QnsNo", obj.QnsNo);
            sqlCmd.Parameters.AddWithValue("@Type", obj.Type);
            sqlCmd.Parameters.AddWithValue("@Category", obj.Category);
            sqlCmd.Parameters.AddWithValue("@Desc", obj.Desc);
            sqlCmd.Parameters.AddWithValue("@HasQnsGroup", obj.HasQnsGroup.ToString());
            sqlCmd.Parameters.AddWithValue("@QnsGroupID", obj.QnsGroupID);
            sqlCmd.Parameters.AddWithValue("@Optional", obj.Optional.ToString());
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

    public int Update(Questionnaire obj)
    {
        int result = 1;
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        try
        {
            SqlCommand sqlCmd = new SqlCommand("updQuestionnaire", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@QnsID", obj.QnsID);
            sqlCmd.Parameters.AddWithValue("@QnsNo", obj.QnsNo);
            sqlCmd.Parameters.AddWithValue("@Type", obj.Type);
            sqlCmd.Parameters.AddWithValue("@Category", obj.Category);
            sqlCmd.Parameters.AddWithValue("@Desc", obj.Desc);
            sqlCmd.Parameters.AddWithValue("@HasQnsGroup", obj.HasQnsGroup.ToString());
            sqlCmd.Parameters.AddWithValue("@QnsGroupID", obj.QnsGroupID);
            sqlCmd.Parameters.AddWithValue("@Optional", obj.Optional.ToString());
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

    public int Delete(int qnsid)
    {
        SqlConnection sqlConn = new SqlConnection(DBConnect);
        int result = 1;
        try
        {
            SqlCommand sqlCmd = new SqlCommand("delQuestionnaire", sqlConn)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCmd.Parameters.AddWithValue("@QnsID", qnsid);
            sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
            sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            result = (int)sqlCmd.Parameters["@rtnValue"].Value; sqlConn.Open();
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

    public List<Questionnaire> Retrieve()
    {
        List<Questionnaire> result = GetData();
        return result;
    }
    
    public Questionnaire SelectByQnsDesc(string desc)
    {
        Questionnaire result = Retrieve().Where(obj => obj.Desc.Equals(desc)).FirstOrDefault();
        return result;
    }    
    
    public Questionnaire SelectByQnsNo(int qnsno)
    {
        Questionnaire result = Retrieve().Where(obj => obj.QnsNo.Equals(qnsno)).FirstOrDefault();
        return result;
    }

    protected List<Questionnaire> GetData()
    {
        List<Questionnaire> result = new List<Questionnaire>();

        try
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT * FROM Questionnaire";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

            DataSet ds = new DataSet();
            da.Fill(ds);
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                Questionnaire obj = ToObj(row);

                result.Add(obj);
            }
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "GetData", e.Message);
        }

        return result;
    }

    protected Questionnaire ToObj(DataRow row)
    {
        Questionnaire obj = null;
        try
        {
            int qnsid = CommonBL.IntegerMapper(row["QnsID"].ToString());
            int qnsno = CommonBL.IntegerMapper(row["QnsNo"].ToString());
            string type = CommonBL.StringMapper(row["Type"]);
            string category = CommonBL.StringMapper(row["Category"]);
            string desc = CommonBL.StringMapper(row["Desc"]);
            bool hasqnsgrp = CommonBL.BoolMapper(row["HasQnsGroup"].ToString());
            int qnsgrpid = CommonBL.IntegerMapper(row["QnsGroupID"].ToString());
            bool optional = CommonBL.BoolMapper(row["Optional"].ToString());
            string cBy = CommonBL.StringMapper(row["CreateBy"]);
            DateTime cDate = CommonBL.DateTimeMapper(row["CreateDate"].ToString());
            string aBy = CommonBL.StringMapper(row["AmendBy"]);
            DateTime aDate = CommonBL.DateTimeMapper(row["AmendDate"].ToString());

            obj = new Questionnaire(qnsid, qnsno, type, category, desc, hasqnsgrp, qnsgrpid, optional, cBy, cDate, aBy, aDate);
        }
        catch (Exception e)
        {
            CommonBL.LogError(this.GetType(), "ToObj", e.Message);
        }

        return obj;
    }

    public string Validate(Questionnaire ValObj, string reqtype)
    {
        StringBuilder errorMsg = new StringBuilder();
        if (string.IsNullOrEmpty(ValObj.Desc))
        {
            errorMsg.Append("Please complete all fields.<br/>");
        }

        Questionnaire QnsObj = SelectByQnsNo(ValObj.QnsNo);
        if (QnsObj != null)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                errorMsg.Append("Question No already exists.<br/>");
            }
        }

        QnsObj = SelectByQnsDesc(ValObj.Desc);
        if (QnsObj != null)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                errorMsg.Append("Question Desc already exists.<br/>");
            }
        }

        return errorMsg.ToString();
    }
}