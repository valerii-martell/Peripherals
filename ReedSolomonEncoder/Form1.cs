using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReedSolomonEncoder
{
    public partial class Form1 : Form
    {
        private Sender Sender;
        private Network Network;
        private Receiver Receiver;

        public Form1()
        {
            InitializeComponent();
        }

        private void encode_Click(object sender, EventArgs e)
        {
            int[] informationSymbols = new int[11];
            try
            {
                informationSymbols[0] = Int32.Parse(informationSymbol0.Text);
                informationSymbols[1] = Int32.Parse(informationSymbol1.Text);
                informationSymbols[2] = Int32.Parse(informationSymbol2.Text);
                informationSymbols[3] = Int32.Parse(informationSymbol3.Text);
                informationSymbols[4] = Int32.Parse(informationSymbol4.Text);
                informationSymbols[5] = Int32.Parse(informationSymbol5.Text);
                informationSymbols[6] = Int32.Parse(informationSymbol6.Text);
                informationSymbols[7] = Int32.Parse(informationSymbol7.Text);
                informationSymbols[8] = Int32.Parse(informationSymbol8.Text);
                informationSymbols[9] = Int32.Parse(informationSymbol9.Text);
                informationSymbols[10] = Int32.Parse(informationSymbol10.Text);

                foreach(int informationSymbol in informationSymbols)
                {
                    if (informationSymbol > 15 || informationSymbol < 0) throw new Exception();
                }

                Sender = new Sender(informationSymbols);

                encode0.Text = Sender.Code[0].ToString();
                encode1.Text = Sender.Code[1].ToString();
                encode2.Text = Sender.Code[2].ToString();
                encode3.Text = Sender.Code[3].ToString();
                encode4.Text = Sender.Code[4].ToString();
                encode5.Text = Sender.Code[5].ToString();
                encode6.Text = Sender.Code[6].ToString();
                encode7.Text = Sender.Code[7].ToString();
                encode8.Text = Sender.Code[8].ToString();
                encode9.Text = Sender.Code[9].ToString();
                encode10.Text = Sender.Code[10].ToString();
                encode11.Text = Sender.Code[11].ToString();
                encode12.Text = Sender.Code[12].ToString();
                encode13.Text = Sender.Code[13].ToString();
                encode14.Text = Sender.Code[14].ToString();

                statusBar.Text = "Code is encoded and sent to the network. Input mistake and press \n'Make a mistake and send to the reciver' button.";

                decode.Enabled = true;
            }
            catch
            {
                statusBar.Text = "Invalid information symbols.";
            }
        }

        private void decode_Click(object sender, EventArgs e)
        {
            int[] errors = new int[15];
            try
            {
                errors[0] = Int32.Parse(error0.Text);
                errors[1] = Int32.Parse(error1.Text);
                errors[2] = Int32.Parse(error2.Text);
                errors[3] = Int32.Parse(error3.Text);
                errors[4] = Int32.Parse(error4.Text);
                errors[5] = Int32.Parse(error5.Text);
                errors[6] = Int32.Parse(error6.Text);
                errors[7] = Int32.Parse(error7.Text);
                errors[8] = Int32.Parse(error8.Text);
                errors[9] = Int32.Parse(error9.Text);
                errors[10] = Int32.Parse(error10.Text);
                errors[11] = Int32.Parse(error11.Text);
                errors[12] = Int32.Parse(error12.Text);
                errors[13] = Int32.Parse(error13.Text);
                errors[14] = Int32.Parse(error14.Text);

                int errorCount = 0;
                int errorPos = 0;
                for (int i = 0; i<15; i++)
                {
                    if (errors[i] > 15 || errors[i] < 0) throw new Exception();
                    if (errors[i] != 0)
                    {
                        errorCount++;
                        errorPos = i;
                    }
                }

                Network = new Network(Sender.Code, errors);

                recived0.Text = Network.Code[0].ToString();
                recived1.Text = Network.Code[1].ToString();
                recived2.Text = Network.Code[2].ToString();
                recived3.Text = Network.Code[3].ToString();
                recived4.Text = Network.Code[4].ToString();
                recived5.Text = Network.Code[5].ToString();
                recived6.Text = Network.Code[6].ToString();
                recived7.Text = Network.Code[7].ToString();
                recived8.Text = Network.Code[8].ToString();
                recived9.Text = Network.Code[9].ToString();
                recived10.Text = Network.Code[10].ToString();
                recived11.Text = Network.Code[11].ToString();
                recived12.Text = Network.Code[12].ToString();
                recived13.Text = Network.Code[13].ToString();
                recived14.Text = Network.Code[14].ToString();

                Receiver = new Receiver(Network.Code);

                decoded0.Text = Receiver.ReceivedCode[0].ToString();
                decoded1.Text = Receiver.ReceivedCode[1].ToString();
                decoded2.Text = Receiver.ReceivedCode[2].ToString();
                decoded3.Text = Receiver.ReceivedCode[3].ToString();
                decoded4.Text = Receiver.ReceivedCode[4].ToString();
                decoded5.Text = Receiver.ReceivedCode[5].ToString();
                decoded6.Text = Receiver.ReceivedCode[6].ToString();
                decoded7.Text = Receiver.ReceivedCode[7].ToString();
                decoded8.Text = Receiver.ReceivedCode[8].ToString();
                decoded9.Text = Receiver.ReceivedCode[9].ToString();
                decoded10.Text = Receiver.ReceivedCode[10].ToString();

                statusBar.Text = "Receiver received code and decoded it. ";

                if (errorCount == 0)
                {
                    statusBar.Text = "Message successfully received.\nFind 0 mistakes.";
                }
                if (errorCount == 1)
                {
                    statusBar.Text += "Find 1 mistake in position: " + errorPos + ". ";
                    statusBar.Text += "\nPress 'Restore message' button.";
                    restore.Enabled = true;
                }
                if (errorCount == 2)
                {
                    statusBar.Text += "Find 2 mistakes in positions: " + Receiver.ErrorsPositions[0] + " and " + Receiver.ErrorsPositions[1] + ". ";
                    statusBar.Text += "\nPress 'Restore message' button.";
                    restore.Enabled = true;
                }
                
                
            }
            catch
            {
                statusBar.Text = "Invalid error code.";
            }
        }

        private void restore_Click(object sender, EventArgs e)
        {
            restored0.Text = Receiver.RecoveredCode[0].ToString();
            restored1.Text = Receiver.RecoveredCode[1].ToString();
            restored2.Text = Receiver.RecoveredCode[2].ToString();
            restored3.Text = Receiver.RecoveredCode[3].ToString();
            restored4.Text = Receiver.RecoveredCode[4].ToString();
            restored5.Text = Receiver.RecoveredCode[5].ToString();
            restored6.Text = Receiver.RecoveredCode[6].ToString();
            restored7.Text = Receiver.RecoveredCode[7].ToString();
            restored8.Text = Receiver.RecoveredCode[8].ToString();
            restored9.Text = Receiver.RecoveredCode[9].ToString();
            restored10.Text = Receiver.RecoveredCode[10].ToString();

            statusBar.Text = "Message successfully restored.";
        }
    }
}
