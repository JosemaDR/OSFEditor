unit FEditorU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  SynEdit;

type

  { TFEditor }

  TFEditor = class(TForm)
    campoEdicion: TMemo;
    mArchivo: TMenuItem;
    mEdicion: TMenuItem;
    mSeparador: TMenuItem;
    mSalirArchivo: TMenuItem;
    mCortar: TMenuItem;
    mPegar: TMenuItem;
    mCopiar: TMenuItem;
    mGuardarComo: TMenuItem;
    mGuardar: TMenuItem;
    mNuevo: TMenuItem;
    mAbrir: TMenuItem;
    ventanaAbrir: TOpenDialog;
    mSalir: TMenuItem;
    menuPrincipal: TMainMenu;
    ventanaGuardar: TSaveDialog;
    procedure campoEdicionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure mAbrirClick(Sender: TObject);
    procedure mCopiarClick(Sender: TObject);
    procedure mCortarClick(Sender: TObject);
    procedure mGuardarClick(Sender: TObject);
    procedure mGuardarComoClick(Sender: TObject);
    procedure mNuevoClick(Sender: TObject);
    procedure mPegarClick(Sender: TObject);
    procedure mSalirArchivoClick(Sender: TObject);
    procedure mSalirClick(Sender: TObject);
  private

  public

  end;

var
  cambiosGuardados : Boolean = true;
  tituloFormularioOriginal : String = 'OSFEditor';
  textoGuardar : ShortString = '¿Guardar?';
  mostradoTextoGuardar : Boolean = false;
  esGuardado : Boolean = false;
  ficheroGuardar : String = '';

  FEditor: TFEditor;

implementation

{$R *.lfm}

{ TFEditor }

procedure TFEditor.FormCreate(Sender: TObject);
begin
  self.Caption := tituloFormularioOriginal + ': Archivo nuevo';
end;

procedure TFEditor.campoEdicionChange(Sender: TObject);
begin
  cambiosGuardados := false;

  if not mostradoTextoGuardar then
  begin
     caption := caption + ' ' + textoGuardar;
     mostradoTextoGuardar := true
  end;
end;

procedure TFEditor.FormPaint(Sender: TObject);
begin
     campoEdicion.Width := self.Width;
     campoEdicion.Height := self.Height;
end;

procedure TFEditor.mAbrirClick(Sender: TObject);
begin
  if ventanaAbrir.Execute then
  begin
     ficheroGuardar := ventanaAbrir.FileName;
     campoEdicion.Lines.LoadFromFile(ficheroGuardar);
     self.Caption := tituloFormularioOriginal + ': ' + ficheroGuardar;
     mostradoTextoGuardar := false;
     esGuardado := true;
     cambiosGuardados := true;
  end;
end;

procedure TFEditor.mCopiarClick(Sender: TObject);
begin
  campoEdicion.CopyToClipboard;
end;

procedure TFEditor.mCortarClick(Sender: TObject);
begin
  campoEdicion.CutToClipboard;
end;

procedure TFEditor.mGuardarClick(Sender: TObject);
begin
  if not esGuardado then
    begin
      if ventanaGuardar.Execute then
        begin
           ficheroGuardar := ventanaGuardar.FileName;
           campoEdicion.Lines.SaveToFile(ventanaGuardar.FileName);
        end;
    end
  else
      begin
        campoEdicion.Lines.SaveToFile(ficheroGuardar);
      end;

  self.Caption := tituloFormularioOriginal + ': ' + ficheroGuardar;
  mostradoTextoGuardar := false;
  esGuardado := true;
  cambiosGuardados := true;
end;

procedure TFEditor.mGuardarComoClick(Sender: TObject);
begin
  if ventanaGuardar.Execute then
    begin
       ficheroGuardar := ventanaGuardar.FileName;
       campoEdicion.Lines.SaveToFile(ficheroGuardar);
       self.Caption := tituloFormularioOriginal + ': ' + ficheroGuardar;
       mostradoTextoGuardar := false;
       esGuardado := true;
       cambiosGuardados := true;
    end;
end;

procedure TFEditor.mNuevoClick(Sender: TObject);
begin
  if not cambiosGuardados then
    begin
       if ventanaGuardar.Execute then
         begin
            ficheroGuardar := ventanaGuardar.FileName;
            campoEdicion.Lines.SaveToFile(ficheroGuardar);
            mostradoTextoGuardar := false;
            cambiosGuardados := true;
         end;
    end;

  self.Caption := tituloFormularioOriginal + ': Archivo nuevo no guardado';
  campoEdicion.Lines.Clear;
end;

procedure TFEditor.mPegarClick(Sender: TObject);
begin
  campoEdicion.PasteFromClipboard;
end;

procedure TFEditor.mSalirArchivoClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFEditor.mSalirClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

