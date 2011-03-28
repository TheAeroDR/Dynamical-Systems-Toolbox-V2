!---------------------------------------------------------------------- 
!---------------------------------------------------------------------- 
!   bvp :    A nonlinear ODE eigenvalue problem
!---------------------------------------------------------------------- 
!---------------------------------------------------------------------- 

SUBROUTINE FUNC(NDIM,U,ICP,PAR,IJAC,F,DFDU,DFDP) 
!--------- ---- 

  IMPLICIT NONE
  INTEGER, INTENT(IN) :: NDIM, IJAC, ICP(*)
  DOUBLE PRECISION, INTENT(IN) :: U(NDIM), PAR(*)
  DOUBLE PRECISION, INTENT(OUT) :: F(NDIM), DFDU(NDIM,*), DFDP(NDIM,*)

  DOUBLE PRECISION pi

  pi = 4.d0*ATAN(1.d0)

  F(1) = U(2)
  F(2) = -( PAR(1)*pi )**2 * U(1) + U(1)**2

RETURN
END SUBROUTINE FUNC

SUBROUTINE STPNT(NDIM,U,PAR,T) 
!--------- ----- 

  IMPLICIT NONE
  INTEGER, INTENT(IN) :: NDIM
  DOUBLE PRECISION, INTENT(IN) :: T
  DOUBLE PRECISION, INTENT(OUT) :: U(NDIM), PAR(*)

  PAR(1:2) = 0.0d0

  U = 0.0d0

RETURN
END SUBROUTINE STPNT

SUBROUTINE BCND(NDIM,PAR,ICP,NBC,U0,U1,FB,IJAC,DBC) 
!--------- ---- 

  IMPLICIT NONE
  INTEGER, INTENT(IN) :: NDIM, ICP(*), NBC, IJAC
  DOUBLE PRECISION, INTENT(IN) :: PAR(*), U0(NDIM), U1(NDIM)
  DOUBLE PRECISION, INTENT(OUT) :: FB(NBC), DBC(NBC,*)

  FB = (/ U0(1), U1(1) /)

RETURN
END SUBROUTINE BCND

SUBROUTINE ICND(NDIM,PAR,ICP,NINT,U,UOLD,UDOT,UPOLD,FI,IJAC,DINT)
!--------- ----

  IMPLICIT NONE
  INTEGER, INTENT(IN) :: NDIM, ICP(*), NINT, IJAC
  DOUBLE PRECISION, INTENT(IN) :: PAR(*)
  DOUBLE PRECISION, INTENT(IN) :: U(NDIM), UOLD(NDIM), UDOT(NDIM), UPOLD(NDIM)
  DOUBLE PRECISION, INTENT(OUT) :: FI(NINT), DINT(NINT,*)

  FI = (/ U(1)-PAR(2) /)
RETURN
END SUBROUTINE ICND

SUBROUTINE FOPT 
RETURN
END SUBROUTINE FOPT

SUBROUTINE PVLS
RETURN
END SUBROUTINE PVLS
