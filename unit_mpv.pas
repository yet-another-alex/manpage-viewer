unit unit_mpv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ListFilterEdit, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    buttonExport: TButton;
    listboxCommands: TListBox;
    listfilterCommands: TListFilterEdit;
    memoOutput: TMemo;
    dialogSaveFile: TSaveDialog;
    procedure buttonExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure listboxCommandsSelectionChange(Sender: TObject; User: boolean);
  private

  public

  end;

var
  Form1: TForm1;
  s : ansistring;
  tmp : ansistring;
  man_s : ansistring;
  commandList : TStringList;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // creat a StringList
  commandList := TStringList.Create;
  // get all installed commands comma-separated via ls -m /bin
  if RunCommand('/bin/ls', ['-m', '/bin'], s) then
    Begin
         // split at ',' to get individual commands
         For tmp in s.Split(',') do
             commandList.Append(tmp.Trim());
         // without filter edit: listboxCommands.Items := commandList;
         // add all commands to the TListFilterEdit
         listfilterCommands.Items.AddStrings(commandList);
         // invalidate the filter to display all items
         listfilterCommands.InvalidateFilter;
    End
end;

procedure TForm1.buttonExportClick(Sender: TObject);
begin
  // prepare a defualt filename with ending
  dialogSaveFile.FileName:=listboxCommands.GetSelectedText + '.txt';
  // display the save file dialog and save contents of TMemo to file
  if dialogSaveFile.Execute then
    memoOutput.Lines.SaveToFile( dialogSaveFile.FileName);
end;

procedure TForm1.listboxCommandsSelectionChange(Sender: TObject; User: boolean);
begin
  // run the man command for the selected command
  if RunCommand('man', [listboxCommands.GetSelectedText], man_s) then
    Begin
         // output to the TMemo, but clear previous man output first
         memoOutput.Clear;
         memoOutput.Append(man_s);
         // enable the TButton for the export
         buttonExport.Enabled:=True;
    end;
end;

end.

