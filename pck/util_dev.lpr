program util_dev;

{$mode objfpc}{$H+}
{$DEFINE UseCThreads}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Classes,
  SysUtils,
  CustApp,
  Crt,
  paxutils { you can add units after this };

type

  { TLockThread }

  TLockThread = class(TThread)
  var
    Semaphore: TSemaphore;
  public
    procedure Execute; override;
  end;

  { TWaitThread }

  TWaitThread = class(TThread)
  var
    Semaphore: TSemaphore;
  public
    procedure Execute; override;
  end;
  { TUtilsDev }

  TUtilsDev = class(TCustomApplication)
  protected
  var
    FSemaphore: TSemaphore;
    FWaiter: TWaitThread;
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
      Semaphore.release();
    except
      ON E: ESemaphoreException do
      begin
        Writeln(E.Message);
      end;
    end;
    Writeln('TWaitThread: Byte');
  end;

  { TLockThread }

  procedure TLockThread.Execute;
  var
    waitTime: word = 1000;
  begin
    Writeln('TLockThread: Semaphore RED, keep red for ', waitTime div 1000, ' seconds (', waitTime div (1000 * 60), ' minutes)');
    Semaphore.acquire();
    while waitTime > 0 do
    begin
      sleep(1);
      Dec(waitTime);
    end;
    Semaphore.release();
    Writeln('TLockThread:  Semaphore GREEN Bye');
  end;

  { TUtilsDev }

  procedure TUtilsDev.DoRun;
  begin
    Writeln;
    repeat
      Sleep(100);
    until not FSemaphore.isInUsed;
    Writeln('Exit');
    Terminate(0);
  end;

  procedure TUtilsDev.AfterConstruction;
  begin
    inherited AfterConstruction;
    FSemaphore        := TMutex.Create;
    fLocker           := TLockThread.Create(True);
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
  Application       := TUtilsDev.Create(nil);
  Application.Title := 'UtilsDevApplication';
  Application.Run;
  Application.Free;
end.
