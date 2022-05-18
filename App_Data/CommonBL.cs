using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.Json;
using System.Text.RegularExpressions;
using System.Web;

public class CommonBL
{
    public readonly static string ConstantType_Add = "Add";
    public readonly static string ConstantType_View = "View";
    public readonly static string ConstantType_Update = "Update";

    public readonly static string ConstantAPIendpoint_GETDEVICES = "devices";
    public readonly static string ConstantAPIendpoint_GETSOUNDLEVEL = "sound_level";
    public readonly static string ConstantAPIendpoint_GETTEMPERATURE = "temperature";
    public readonly static string ConstantAPIendpoint_GETHUMIDITY = "humidity";
    public readonly static string ConstantAPIendpoint_GETMOTION = "motion_events";
    public readonly static string ConstantAPIendpoint_customGETALLREADINGS = "all_readings";

    public readonly static string ConstantCRUD_Create = "Create";
    public readonly static string ConstantCRUD_Update = "Update";
    public readonly static string ConstantCRUD_Delete = "Delete";

    public readonly static string ConstantSensorReadingType_Sound = "Sound";
    public readonly static string ConstantSensorReadingType_Temp = "Temperature";
    public readonly static string ConstantSensorReadingType_Humid = "Humidity";
    public readonly static string ConstantSensorReadingType_Motion = "Motion";

    public readonly static string ConstantChartJsType_Bar = "bar";
    public readonly static string ConstantChartJsType_Bubble = "bubble";
    public readonly static string ConstantChartJsType_Doughnut = "doughnut";
    public readonly static string ConstantChartJsType_Line = "line";
    public readonly static string ConstantChartJsType_Pie = "pie";
    public readonly static string ConstantChartJsType_PolarArea = "polarArea";
    public readonly static string ConstantChartJsType_Radar = "radar";
    public readonly static string ConstantChartJsType_Scatter = "scatter";

    public readonly static string ConstantParameter_AutoGen = "#Auto-generated";
    public readonly static string ConstantParameter_SubQns = "(Has sub-questions)";

    public readonly static System.Web.UI.Page ConstantPageObj = new System.Web.UI.Page();
    public readonly static Regex sWhitespace = new Regex(@"\s+");

    public static void LogError(Type type, string methodName, string ExcMsg)
    {
        string strPath = ConstantPageObj.Server.MapPath("ErrorLog.txt");
        if (!File.Exists(strPath))
        {
            File.Create(strPath).Dispose();
        }
        using (StreamWriter sw = File.AppendText(strPath))
        {
            sw.WriteLine(DateTime.Now.ToString() + " -------- " + type.Name + " | " + methodName + " | " + "Error Encountered: " + ExcMsg);
        }
    }

    public static IEnumerable<DateTime> EachYear(DateTime from, DateTime thru)
    {
        for (var year = from.Date; year.Date <= thru.Date; year = year.AddYears(1))
            yield return year;
    }

    public static IEnumerable<DateTime> EachDay(DateTime from, DateTime thru)
    {
        for (var day = from.Date; day.Date <= thru.Date; day = day.AddDays(1))
            yield return day;
    }

    public static IEnumerable<DateTime> AllDatesInMonth(int year, int month)
    {
        int days = DateTime.DaysInMonth(year, month);
        for (int day = 1; day <= days; day++)
        {
            yield return new DateTime(year, month, day);
        }
    }

    public static List<DateTime> GetWeekdayInRange(DateTime from, DateTime to, DayOfWeek day)
    {
        const int daysInWeek = 7;
        var result = new List<DateTime>();
        var daysToAdd = ((int)day - (int)from.DayOfWeek + daysInWeek) % daysInWeek;

        do
        {
            from = from.AddDays(daysToAdd);
            if (from > to) break;
            result.Add(from);
            daysToAdd = daysInWeek;
        } while (from < to);

        return result;
    }

    public static List<string> GetDayTimeIntervalInRange(TimeSpan starthour, TimeSpan endhour, int interval)
    {
        List<string> result = Enumerable
                                .Range(0, (int)(new TimeSpan(24, 0, 0).TotalMinutes / interval))
                                .Select(i => DateTime.Today.AddMinutes(i * (double)interval))
                                .Where(t => t.TimeOfDay >= starthour && t.TimeOfDay <= endhour)
                                .Select(o => o.ToString("HH:mm")).ToList();
        return result;
    }

    public static DataTable CreateDataTable<T>(IEnumerable<T> list)
    {
        Type type = typeof(T);
        var properties = type.GetProperties();

        DataTable dataTable = new DataTable
        {
            TableName = typeof(T).FullName
        };
        foreach (PropertyInfo info in properties)
        {
            dataTable.Columns.Add(new DataColumn(info.Name, Nullable.GetUnderlyingType(info.PropertyType) ?? info.PropertyType));
        }

        foreach (T entity in list)
        {
            object[] values = new object[properties.Length];
            for (int i = 0; i < properties.Length; i++)
            {
                values[i] = properties[i].GetValue(entity);
            }

            dataTable.Rows.Add(values);
        }

        return dataTable;
    }

    public static string StringMapper(object obj)
    {
        if (obj == null)
            return "";
        else
            return obj.ToString();
    }

    public static int IntegerMapper(string obj)
    {
        if (string.IsNullOrEmpty(obj))
            return 0;
        else
            return int.Parse(obj);
    }

    public static float FloatMapper(string obj)
    {
        if (string.IsNullOrEmpty(obj))
            return 0;
        else
            return float.Parse(obj);
    }

    public static bool BoolMapper(string obj)
    {
        if (obj == null)
            return false;
        else
            return bool.Parse(obj);
    }

    public static DateTime DateTimeMapper(string obj)
    {
        if (string.IsNullOrEmpty(obj))
            return new DateTime();
        else
            return DateTime.Parse(obj);
    }

    public static DayOfWeek DayOfWeekMapper(string obj)
    {
        if (obj == "Sunday")
            return DayOfWeek.Sunday;
        else if (obj == "Monday")
            return DayOfWeek.Monday;
        else if (obj == "Tuesday")
            return DayOfWeek.Tuesday;
        else if (obj == "Wednesday")
            return DayOfWeek.Wednesday;
        else if (obj == "Thursday")
            return DayOfWeek.Thursday;
        else if (obj == "Friday")
            return DayOfWeek.Friday;
        else if (obj == "Saturday")
            return DayOfWeek.Saturday;
        else
            return new DayOfWeek();
    }

    public static bool CheckValidExcelFile(string filename)
    {
        string ext = Path.GetExtension(filename);
        switch (ext.ToLower())
        {
            case ".xlsx":
                return true;
            case ".xlsm":
                return true;
            case ".xltx":
                return true;
            case ".xltm":
                return true;
            default:
                return false;
        }
    }

    public static string CleanText(string originalText)
    {
        string result = originalText;
        //Get rid of trailing whitespace characters
        result = result.Trim();
        //Get rid of extra whitespace in between texts
        result = string.Join(" ", result.Split(' ').ToList());
        //Standardize the use Typography characters
        if (result.IndexOf('\u2013') > -1) result = result.Replace('\u2013', '-'); // en dash
        if (result.IndexOf('\u2014') > -1) result = result.Replace('\u2014', '-'); // em dash
        if (result.IndexOf('\u2015') > -1) result = result.Replace('\u2015', '-'); // horizontal bar
        if (result.IndexOf('\u2017') > -1) result = result.Replace('\u2017', '_'); // double low line
        if (result.IndexOf('\u2018') > -1) result = result.Replace('\u2018', '\''); // left single quotation mark
        if (result.IndexOf('\u2019') > -1) result = result.Replace('\u2019', '\''); // right single quotation mark
        if (result.IndexOf('\u201a') > -1) result = result.Replace('\u201a', ','); // single low-9 quotation mark
        if (result.IndexOf('\u201b') > -1) result = result.Replace('\u201b', '\''); // single high-reversed-9 quotation mark
        if (result.IndexOf('\u201c') > -1) result = result.Replace('\u201c', '\"'); // left double quotation mark
        if (result.IndexOf('\u201d') > -1) result = result.Replace('\u201d', '\"'); // right double quotation mark
        if (result.IndexOf('\u201e') > -1) result = result.Replace('\u201e', '\"'); // double low-9 quotation mark
        if (result.IndexOf('\u2026') > -1) result = result.Replace("\u2026", "..."); // horizontal ellipsis
        if (result.IndexOf('\u2032') > -1) result = result.Replace('\u2032', '\''); // prime
        if (result.IndexOf('\u2033') > -1) result = result.Replace('\u2033', '\"'); // double prime

        return result;
    }

    public static string PrettyPrintJson(string unPrettyJson)
    {
        var options = new JsonSerializerOptions()
        {
            WriteIndented = true
        };

        var jsonElement = JsonSerializer.Deserialize<JsonElement>(unPrettyJson);

        return JsonSerializer.Serialize(jsonElement, options);
    }

    public static string ReplaceWhitespace(string input, string replacement)
    {
        return sWhitespace.Replace(input, replacement);
    }

    internal static object DateTimeMapper(object p)
    {
        throw new NotImplementedException();
    }
}