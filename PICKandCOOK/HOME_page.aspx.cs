using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using NAudio.Wave;

namespace PICKandCOOK
{
    public partial class HOME_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private IWavePlayer waveOutDevice;
        private AudioFileReader audioFileReader;

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Specify the path to your audio file
            string audioFilePath = Server.MapPath("~/videos/voice.mp3");

            // Play the audio file
            PlayAudio(audioFilePath);
        }

        private void LogError(string message)
        {
            try
            {
                string logPath = Server.MapPath("~/logs/Log3.txt");
                using (StreamWriter writer = new StreamWriter(logPath, true))
                {
                    writer.WriteLine($"{DateTime.Now}: {message}");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error :" + ex.Message);
            }
        }

        private void PlayAudio(string filePath)
        {
            try
            {
                // Initialize the audio player
                waveOutDevice = new WaveOutEvent();
                audioFileReader = new AudioFileReader(filePath);
                waveOutDevice.Init(audioFileReader);
                waveOutDevice.Play();

                // Optionally, you can handle the PlaybackStopped event
                waveOutDevice.PlaybackStopped += (s, a) =>
                {
                    // Clean up resources
                    audioFileReader.Dispose();
                    waveOutDevice.Dispose();
                };
            }
            catch (Exception ex)
            {
                LogError($"Error playing audio: {ex.Message}");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("LOGIN_page.aspx");
        }

    }

}