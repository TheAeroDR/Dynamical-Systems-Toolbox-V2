!---------------------------------------------------------------------
      SUBROUTINE DEALLOCATEF7()      
!
      USE AUTO_CONSTANTS
!      
! F7
!
      IF(ALLOCATED(IBRF7))DEALLOCATE(IBRF7)
      IF(ALLOCATED(oldIBRF7))DEALLOCATE(oldIBRF7)
      IF(ALLOCATED(MTOTF7))DEALLOCATE(MTOTF7)
      IF(ALLOCATED(oldMTOTF7))DEALLOCATE(oldMTOTF7)
      IF(ALLOCATED(ITPF7))DEALLOCATE(ITPF7)
      IF(ALLOCATED(oldITPF7))DEALLOCATE(oldITPF7)
      IF(ALLOCATED(LABF7))DEALLOCATE(LABF7)
      IF(ALLOCATED(oldLABF7))DEALLOCATE(oldLABF7)
      IF(ALLOCATED(PARF7))DEALLOCATE(PARF7)
      IF(ALLOCATED(oldPARF7))DEALLOCATE(oldPARF7)
      IF(ALLOCATED(VAXISF7))DEALLOCATE(VAXISF7)
      IF(ALLOCATED(oldVAXISF7))DEALLOCATE(oldVAXISF7)
      IF(ALLOCATED(UF7))DEALLOCATE(UF7)
      IF(ALLOCATED(oldUF7))DEALLOCATE(oldUF7)
      IF(ALLOCATED(OUTF7))DEALLOCATE(OUTF7)
      IF(ALLOCATED(oldOUTF7))DEALLOCATE(oldOUTF7)
!
      RETURN
      END      
!