program util_dev;

{$Mode ObjFPC}{$H+}
{$DEFINE UseCThreads}

uses
  {$IFDEF UNIX} {$IFDEF UseCThreads}cthreads,{$ENDIF}{$ENDIF}
  Classes,
  SysUtils,
  CustApp,
  Crt,
  {$IfDef Windows}
  Windows,
  {$EndIf}
  Interfaces,
  pax.utils,
  pax.utils.colors,
  pax.utils.containers,
  pax.utils.arraylist,
  pax.utils.linkedlist,
  pax.utils.calendars;

type
  { TLockThread }

  TLockThread = class(TThread)
  protected
    Semaphore: TSemaphore;
  public
    procedure Execute; override;
  end;

  { TWaitThread }

  TWaitThread = class(TThread)
  protected
    Semaphore: TSemaphore;
  public
    procedure Execute; override;
  end;
  { TUtilsDev }

  TUtilsDev = class(TCustomApplication)
  protected
    fSemaphore: TSemaphore;
    fWaiter: TWaitThread;
    fLocker: TLockThread;
    procedure DoRun; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  { TWaitThread }

  procedure TWaitThread.Execute;
  begin
    Writeln('TWaitThread: Wait the green');
    try
      Semaphore.acquire();
      Semaphore.Release();
    except
      ON E: ESemaphoreException do
      begin
        Writeln(E.Message);
      end;
    end;
    Writeln('TWaitThread: Bye');
  end;

  { TLockThread }

  procedure TLockThread.Execute;
  var
    waitTime: word = 1000;
  begin
    Writeln('TLockThread: Semaphore RED, keep red for ', waitTime div 1000, ' seconds (', waitTime div (1000 * 60), ' minutes)');
    Semaphore.acquire();
    sleep(waitTime);
    Semaphore.Release();
    Writeln('TLockThread:  Semaphore GREEN Bye');
  end;

  { TUtilsDev }

  procedure TUtilsDev.DoRun;
  var
    t: TTimer = 0;
  begin
    getUserLocale;
    t.restart;
    Writeln;
    repeat
      Sleep(100);
    until not FSemaphore.isInUsed;
    Writeln('Exit after ', t.elapsed.toString);
    Writeln('Press any key to terminate');
    ReadKey;
    Terminate(0);
  end;

  procedure TUtilsDev.AfterConstruction;
  begin
    inherited AfterConstruction;
    FSemaphore := TMutex.Create;
    fLocker := TLockThread.Create(True);
    fLocker.Semaphore := FSemaphore;
    fLocker.Start;
    FWaiter := TWaitThread.Create(True);
    FWaiter.Semaphore := FSemaphore;
    FWaiter.Start;
  end;

  procedure TUtilsDev.BeforeDestruction;
  begin
    FWaiter.Terminate;
    FLocker.Terminate;
    FreeAndNil(FWaiter);
    FreeAndNil(FLocker);
    FreeAndNil(FSemaphore);
    inherited BeforeDestruction;
  end;

var
  Application: TUtilsDev;

begin

  Application := TUtilsDev.Create(nil);
  Application.Title := 'UtilsDevApplication';
  Application.Run;
  Application.Free;

end.
